import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class EditTask implements UseCase<String, EditTaskParams> {
  final TaskRepository taskRepository;

  const EditTask(this.taskRepository);

  @override
  Future<Either<Failure, String>> call(EditTaskParams params) async {
    return await taskRepository.editTask(
      taskId: params.taskId,
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
      numWorker: params.numWorker,
    );
  }
}

class EditTaskParams {
  final int taskId;
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
  final int numWorker;

  EditTaskParams({
    required this.taskId,
    required this.title,
    required this.taskCategory,
    required this.reward,
    required this.doneDate,
    required this.description,
    required this.workType,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.numWorker,
    this.scheduleTime,
  });
}
