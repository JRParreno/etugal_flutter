// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/cubit/review_star_cubit.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/performer_task_list/performer_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/index.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_detail/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/review_form_bottom_modal.dart';
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
  final TextEditingController feedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    task = widget.task;
    _setMarker(LatLng(widget.task.latitude, widget.task.longitude));
    context.read<MyTaskDetailBloc>().add(InitialMyTaskDetailEvent(task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<MyTaskDetailBloc, MyTaskDetailState>(
        listener: blocListener,
        builder: (context, state) {
          TaskEntity temp = task;
          if (state is MyTaskDetailInitial) {
            temp = state.taskEntity ?? task;
          }
          return Container(
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
                  if (temp.review != null)
                    TaskShortReview(
                      review: temp.review!,
                      isPerformerEdit: true,
                      onTapEdit: () {
                        context.read<ReviewStarCubit>().onChangeStars(
                            temp.review?.performerRate.toDouble() ?? 0);
                        feedController.text =
                            temp.review?.performerFeedback ?? '';
                        addFeedbackBottomSheetDialog(
                          task: task,
                          context: context,
                          controller: feedController,
                          isProvider: false,
                        );
                      },
                    ),
                  TaskInfo(
                    numWorker: task.numWorker,
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
          );
        },
      ),
      bottomNavigationBar: PerformerBottomBar(
        onSetPerformDone: handleOnTapSetPerformDone,
        onAddReview: () {
          context.read<ReviewStarCubit>().onChangeStars(0);
          addFeedbackBottomSheetDialog(
            task: task,
            context: context,
            controller: feedController,
            isProvider: false,
          );
        },
      ),
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

    if (state is MyTaskDetailInitial) {
      final myTaskEntity = state.taskEntity;

      if (myTaskEntity != null) {
        if (myTaskEntity.isDonePerform != task.isDonePerform ||
            task.review != myTaskEntity.review) {
          handleSetPerformerTaskUpdate(myTaskEntity);
          Future.delayed(const Duration(milliseconds: 500), () {
            LoadingScreen.instance().hide();
          });
        }
      }
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

  void handleOnTapSetPerformDone() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      style: AdaptiveStyle.iOS,
      title: 'E-Tugal',
      message: 'Are you sure you want to set as perform done?',
      canPop: true,
      okLabel: 'Ok',
      cancelLabel: 'Cancel',
    );

    if (result.name != OkCancelResult.cancel.name) {
      handleSetPerformDone();
    }
  }

  void handleSetPerformerTaskUpdate(TaskEntity updatedTask) {
    context.read<PerformerTaskListBloc>().add(UpdateTaskEvent(updatedTask));
  }

  void handleSetPerformDone() {
    context.read<MyTaskDetailBloc>().add(SetPerformIsDoneTaskDetailEvent());
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
