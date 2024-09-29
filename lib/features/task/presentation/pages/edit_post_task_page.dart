import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/enums/work_type.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/edit_task/edit_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EditPostTaskPage extends StatefulWidget {
  const EditPostTaskPage({super.key, required this.task});

  final TaskEntity task;

  @override
  State<EditPostTaskPage> createState() => _EditPostTaskPageState();
}

class _EditPostTaskPageState extends State<EditPostTaskPage> {
  int _index = 0;
  TaskCategoryEntity? _selectedCategory;
  WorkType? _workType;
  late DateTime _dateSelected;
  TimeOfDay? _timeSelected;
  LatLng latLng = const LatLng(13.2907648, 123.4908591);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _describeController = TextEditingController();
  final TextEditingController _searchLocationCtrl = TextEditingController();
  final TextEditingController _rewardCtrl = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _dateSelected = DateTime.now();
    _setMarker(latLng);
    context.read<AddTaskCategoryBloc>().add(GetAddTaskCategoryEvent());
    handleInitEditTask(widget.task);
  }

  @override
  void dispose() {
    super.dispose();
    _describeController.dispose();
    _searchLocationCtrl.dispose();
    _rewardCtrl.dispose();
    _titleController.dispose();
  }

  void handleInitEditTask(TaskEntity task) {
    final List<String> taskSchedule = task.scheduleTime?.split(':') ?? [];
    final TimeOfDay? convertTimeOfDay = taskSchedule.isNotEmpty
        ? TimeOfDay(
            hour: int.parse(taskSchedule[0]),
            minute: int.parse(taskSchedule[1]))
        : null;
    setState(() {
      _timeSelected = convertTimeOfDay;
      _dateSelected = task.doneDate;
      _selectedCategory = task.taskCategory;
      _workType = task.workType == WorkType.inPerson.name
          ? WorkType.inPerson
          : WorkType.online;
      latLng = LatLng(task.latitude, task.longitude);
    });
    _describeController.text = task.description;
    _rewardCtrl.text = task.reward.toString();
    _searchLocationCtrl.text = task.address;
    _titleController.text = task.title;
    _goToTheLocation(LatLng(task.latitude, task.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Edit task',
          style: textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: _index > 0
            ? IconButton(
                onPressed: handleBack,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      body: BlocListener<EditTaskBloc, EditTaskState>(
        listener: blocListener,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormSteps(
                currentStep: _index,
                numSteps: 4,
              ),
              Flexible(
                child: handleFormWidgets(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void blocListener(BuildContext context, EditTaskState state) {
    if (state is AddTaskLoading) {
      LoadingScreen.instance().show(context: context);
    }

    if (state is EditTaskFailure || state is EditTaskSuccess) {
      Future.delayed(const Duration(milliseconds: 500), () {
        LoadingScreen.instance().hide();
      });
    }

    if (state is EditTaskSuccess) {
      onFormDialog(
        message: state.message,
        header: 'Success',
        onTapOk: () {
          context.read<ProviderTaskListBloc>().add(
                const GetProviderTaskListTaskEvent(
                  taskStatus: TaskStatusEnum.pending,
                  index: 0,
                ),
              );
          Future.delayed(const Duration(milliseconds: 500), () {
            context.go(AppRoutes.myTaskList.path);
          });
        },
      );
    }

    if (state is EditTaskFailure) {
      onFormDialog(message: state.message, header: 'Error');
    }
  }

  void onFormDialog({
    required String message,
    required String header,
    VoidCallback? onTapOk,
  }) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: header,
        message: message,
      ).whenComplete(
        () {
          if (onTapOk != null) {
            onTapOk();
          }
        },
      );
    });
  }

  Widget handleFormWidgets() {
    switch (_index) {
      case 0:
        return FirstStepForm(
          selectedWorkType: _workType,
          selectedCategory: _selectedCategory,
          onSelectCategory: (value) =>
              setState(() => _selectedCategory = value),
          onSelectWorkType: (value) => setState(() => _workType = value),
          onNext: handleNext,
        );
      case 1:
        return SecondStepForm(
          controller: _describeController,
          googleMapController: _controller,
          initialCameraPosition: CameraPosition(
            target: latLng,
            zoom: 14.4746,
          ),
          searchLocationCtrl: _searchLocationCtrl,
          onNext: handleNext,
          onPrediction: (prediction) {
            if (prediction.lat != null && prediction.lng != null) {
              final latitude = double.parse(prediction.lat!);
              final longitude = double.parse(prediction.lng!);

              _goToTheLocation(LatLng(latitude, longitude));
            }
          },
          markers: _markers,
          titleController: _titleController,
        );

      case 2:
        return ThirdStepForm(
          dateSelected: _dateSelected,
          timeSelected: _timeSelected,
          onNext: handleNext,
          onSetDate: (value) async {
            final date = await value;
            if (date != null) {
              setState(() {
                _dateSelected = date;
              });
            }
          },
          onSetTime: (value) async {
            final time = await value;
            if (time != null) {
              setState(() {
                _timeSelected = time;
              });
            }
          },
        );
      case 3:
        return FourthStepForm(
          rewardCtrl: _rewardCtrl,
          onSubmit: () {
            setState(() {});
          },
          onNext: () {
            context.read<EditTaskBloc>().add(
                  SubmitEditTaskEvent(
                    EditTaskParams(
                      taskId: widget.task.id,
                      title: _titleController.value.text,
                      taskCategory: _selectedCategory!.id,
                      reward: double.parse(_rewardCtrl.value.text),
                      doneDate: DateFormat('y-M-d').format(_dateSelected),
                      scheduleTime: _timeSelected != null
                          ? '${_timeSelected!.hour}:${_timeSelected!.minute}'
                          : null,
                      description: _describeController.value.text,
                      workType: getWorkTypeFromEnum(_workType!),
                      address: _searchLocationCtrl.value.text,
                      longitude: latLng.longitude,
                      latitude: latLng.latitude,
                    ),
                  ),
                );
          },
        );

      default:
        return const SizedBox();
    }
  }

  Future<void> _goToTheLocation(LatLng prediction) async {
    final tempLatLng = LatLng(prediction.latitude, prediction.longitude);

    setState(() {
      latLng = tempLatLng;

      _markers.add(
        Marker(
          markerId: MarkerId(tempLatLng.toString()),
          position: tempLatLng,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${tempLatLng.latitude}, ${tempLatLng.longitude}',
          ),
        ),
      );
    });

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: tempLatLng,
          zoom: 14.4746,
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

  void handleOnTapBirthdate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(3000, 1, 1),
      currentDate: DateTime.now(),
    );

    if (date != null) {
      _dateSelected = date;
    }
  }

  void handleNext() {
    if (_index >= 0 && _index < 4) {
      setState(() {
        _index += 1;
      });
      if (_index == 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _goToTheLocation(latLng);
        });
      }
    }
  }

  void handleBack() {
    if (_index >= 1 && _index < 4) {
      setState(() {
        _index -= 1;
      });
      if (_index == 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _goToTheLocation(latLng);
        });
      }
    }
  }
}
