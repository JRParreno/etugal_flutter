// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPerformerTaskDetailPage extends StatefulWidget {
  const MyPerformerTaskDetailPage({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  State<MyPerformerTaskDetailPage> createState() =>
      _MyPerformerTaskDetailPageState();
}

class _MyPerformerTaskDetailPageState extends State<MyPerformerTaskDetailPage> {
  late TaskEntity task;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    task = widget.task;
    _setMarker(LatLng(widget.task.latitude, widget.task.longitude));
    context.read<MyTaskDetailBloc>().add(InitialMyTaskDetailEvent(task.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocListener<MyTaskDetailBloc, MyTaskDetailState>(
        listener: blocListener,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(27),
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.borderColor),
            borderRadius: BorderRadius.circular(5),
          ),
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
                  fullName:
                      '${task.provider.user.firstName} ${task.provider.user.lastName}',
                  gender: task.provider.gender,
                  provider: task.provider,
                ),
                const Divider(
                  color: ColorName.borderColor,
                ),
                if (task.performer != null) ...[
                  PerformerInfo(
                    taskUserProfile: task.performer!,
                    isHideViewProfile: true,
                  ),
                  const Divider(
                    color: ColorName.borderColor,
                  ),
                ],
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
      bottomNavigationBar:
          getTaskStatusFromString(task.status) != TaskStatusEnum.canceled &&
                  getTaskStatusFromString(task.status) != TaskStatusEnum.pending
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      // so here your custom shadow goes:
                      BoxShadow(
                        color: Colors.black.withAlpha(
                            20), // the color of a shadow, you can adjust it
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
                    child: CustomElevatedBtn(
                      backgroundColor: getTaskStatusFromString(task.status) ==
                              TaskStatusEnum.inProgres
                          ? Colors.red
                          : null,
                      onTap: getTaskStatusFromString(task.status) ==
                              TaskStatusEnum.inProgres
                          ? () {
                              // TODO mark as completed
                            }
                          : task.isDonePerform &&
                                  getTaskStatusFromString(task.status) ==
                                      TaskStatusEnum.competed
                              ? () {
                                  // TODO add review
                                }
                              : null,
                      title: getTaskStatusFromString(task.status) ==
                                  TaskStatusEnum.inProgres &&
                              !task.isDonePerform
                          ? 'Mark as Completed'
                          : 'Add Review',
                    ),
                  ),
                )
              : null,
    );
  }

  void blocListener(BuildContext context, MyTaskDetailState state) {
    if (state is MyTaskDetailLoading) {
      LoadingScreen.instance().show(context: context);
    }

    if (state is MyTaskDetailFailure || state is MyTaskDetailSuccess) {
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingScreen.instance().hide();
      });
    }

    if (state is MyTaskDetailSuccess) {
      handleRedirection(
        isAccept: state.isAccept,
        taskStatus: state.taskStatusEnum,
      );
    }

    if (state is MyTaskDetailFailure) {
      onFormError(state.message);
    }
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

  void handleRedirection({
    bool isAccept = false,
    TaskStatusEnum? taskStatus,
  }) {
    int tabIndex = isAccept ? 1 : -1;

    switch (taskStatus) {
      case TaskStatusEnum.canceled:
        tabIndex = 3;
        break;
      case TaskStatusEnum.competed:
        tabIndex = 2;
        break;
      default:
    }

    context.read<ProviderTaskListBloc>().add(
          GetProviderTaskListTaskEvent(
            taskStatus: taskStatus ?? TaskStatusEnum.inProgres,
            index: tabIndex,
          ),
        );
    Future.delayed(const Duration(milliseconds: 500), () {
      context.pop();
    });
  }
}