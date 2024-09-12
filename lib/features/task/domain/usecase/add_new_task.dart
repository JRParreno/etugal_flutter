import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class AddNewTask implements UseCase<String, AddNewTaskParams> {
  final TaskRepository taskRepository;

  const AddNewTask(this.taskRepository);

  @override
  Future<Either<Failure, String>> call(AddNewTaskParams params) async {
    return await taskRepository.addNewTask(
      title: params.title,
      taskCategory: params.taskCategory,
      reward: params.reward,
      doneDate: params.doneDate,
      scheduleTime: params.scheduleTime,
      description: params.description,
      workType: params.workType,
      address: params.address,
      longitude: params.longitude,
      latitude: params.latitude,
    );
  }
}

class AddNewTaskParams {
  final String title;
  final int taskCategory;
  final double reward;
  final String doneDate;
  final String description;
  final String workType;
  final String address;
  final double longitude;
  final double latitude;
  final String? scheduleTime;

  AddNewTaskParams({
    required this.title,
    required this.taskCategory,
    required this.reward,
    required this.doneDate,
    required this.description,
    required this.workType,
    required this.address,
    required this.longitude,
    required this.latitude,
    this.scheduleTime,
  });
}
