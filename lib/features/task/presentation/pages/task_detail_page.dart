import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/core/helper/verification_helper.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_detail/task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TaskEntity task;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};
  final TextEditingController intialMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    task = widget.task;
    context.read<TaskDetailBloc>().add(InitialTaskDetailEvent(task.id));
    _setMarker(LatLng(widget.task.latitude, widget.task.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(27),
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: BlocListener<TaskDetailBloc, TaskDetailState>(
          listener: blocListener,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProviderProfile(
                  title: task.title,
                  address: task.address,
                  createdAt: task.createdAt,
                  profilePhoto: task.provider.profilePhoto,
                ),
                const Divider(
                  color: ColorName.borderColor,
                ),
                ProviderInfo(
                  fullName: task.provider.user.getFullName!,
                  gender: task.provider.gender,
                  provider: task.provider,
                ),
                const Divider(
                  color: ColorName.borderColor,
                ),
                TaskInfo(
                  scheduleTime: task.scheduleTime,
                  doneDate: task.doneDate,
                  reward: task.reward,
                  workType: task.workType,
                  description: task.description,
                  googleMapController: _controller,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(task.latitude, task.longitude),
                    zoom: 14.4746,
                  ),
                ),
              ].withSpaceBetween(height: 20),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            // so here your custom shadow goes:
            BoxShadow(
              color: Colors.black
                  .withAlpha(20), // the color of a shadow, you can adjust it
              spreadRadius:
                  3, //also play with this two values to achieve your ideal result
              blurRadius: 7,
              offset: const Offset(0,
                  -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 20,
          ),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedBtn(
                  buttonType: ButtonType.outline,
                  onTap: () {
                    VerificationHelper.handleOnTapPostAdd(
                        context: context,
                        defaultAction: () {
                          // TODO Chat
                        });
                  },
                  title: 'Message',
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: CustomElevatedBtn(
                  onTap: () {
                    VerificationHelper.handleOnTapPostAdd(
                        context: context,
                        defaultAction: () {
                          applyBottomSheetDialog(context: context, task: task);
                        });
                  },
                  title: 'Apply',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${point.latitude}, ${point.longitude}',
          ),
        ),
      );
    });
  }

  void blocListener(BuildContext context, TaskDetailState state) {
    if (state is TaskDetailLoading) {
      LoadingScreen.instance().show(context: context);
    }

    if (state is TaskDetailFailure || state is TaskDetailSuccess) {
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingScreen.instance().hide();
      });
    }

    if (state is TaskDetailSuccess) {
      // TODO handle redirection
    }

    if (state is TaskDetailFailure) {
      onFormError(state.message);
    }
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message: message,
      );
    });
  }

  Future<void> applyBottomSheetDialog({
    required BuildContext context,
    required TaskEntity task,
    VoidCallback? onClose,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Easy Apply',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Initial Message',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: ColorName.darkerGreyFont),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      keyboardType: TextInputType.multiline,
                      hintText: 'Write a short pitch about yourself!',
                      controller: intialMessage,
                      minLines: 6,
                      maxLines: 20,
                      maxLength: 500,
                    ),
                  ],
                ),
                CustomElevatedBtn(
                  onTap: () => context.pop('submit'),
                  title: 'Submit',
                ),
              ].withSpaceBetween(height: 15),
            ),
          ),
        );
      },
    ).then(
      (value) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (value == 'submit') {
            final appUserCubit = context.read<AppUserCubit>().state;
            if (appUserCubit is AppUserLoggedIn) {
              context.read<TaskDetailBloc>().add(
                    EasyApplyTaskDetailEvent(
                      performerId: int.parse(appUserCubit.user.profilePk),
                      description: intialMessage.value.text,
                    ),
                  );
            }
            return;
          }
        });
      },
    );
  }
}
