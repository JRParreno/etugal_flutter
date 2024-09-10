import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/home/data/models/index.dart';

abstract interface class TaskRemoteDataSource {
  Future<String> addNewTask({
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String scheduleTime,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
  });
  Future<TaskListResponseModel> getProviderTaskList({
    required TaskStatusEnum taskStatus,
    String? previous,
    String? next,
  });
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<String> addNewTask({
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String scheduleTime,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
  }) async {
    String url = '$baseUrl/api/provider/tasks/';

    final data = {
      "title": title,
      "task_category": taskCategory,
      "reward": reward,
      "done_date": doneDate,
      "schedule_time": scheduleTime,
      "description": description,
      "work_type": workType,
      "address": address,
      "longitude": longitude,
      "latitude": latitude
    };

    try {
      await apiInstance.post(url, data: data);
      return 'Successfully add new task!';
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskListResponseModel> getProviderTaskList({
    required TaskStatusEnum taskStatus,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/provider/tasks/';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
