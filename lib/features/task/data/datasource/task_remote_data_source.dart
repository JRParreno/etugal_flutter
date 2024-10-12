import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/home/data/models/index.dart';
import 'package:etugal_flutter/features/task/data/models/index.dart';

abstract interface class TaskRemoteDataSource {
  Future<String> addNewTask({
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    String? scheduleTime,
  });
  Future<String> editTask({
    required int taskId,
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    String? scheduleTime,
  });
  Future<TaskListResponseModel> getProviderTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  });
  Future<void> setTaskPerformer({
    required int performerId,
    required int taskId,
  });
  Future<void> updateTaskStatus({
    required String taskStatus,
    required int taskId,
  });
  Future<TaskReviewListModel> getTaskPerformerReview({
    required int id,
    String? previous,
    String? next,
  });
  Future<TaskReviewListModel> getTaskProviderReview({
    required int id,
    String? previous,
    String? next,
  });
  Future<void> easyApplyTask({
    required int performerId,
    required int taskId,
    String? description,
  });
  Future<TaskListResponseModel> getPerformerTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  });
  Future<TaskModel> setPerformIsDone(int taskId);
  Future<TaskShortReviewModel> providerReview({
    required int rate,
    required String feedback,
    required int taskId,
  });
  Future<TaskShortReviewModel> performerReview({
    required int rate,
    required String feedback,
    required int taskId,
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
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    String? scheduleTime,
  }) async {
    String url = '$baseUrl/api/provider/task/';

    final data = {
      "title": title,
      "task_category_id": taskCategory,
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
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> editTask({
    required int taskId,
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    String? scheduleTime,
  }) async {
    String url = '$baseUrl/api/provider/task/$taskId/';

    final data = {
      "title": title,
      "task_category_id": taskCategory,
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
      await apiInstance.patch(url, data: data);
      return 'Successfully update task!';
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskListResponseModel> getProviderTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/provider/task/';

    if (taskStatus != null) {
      url += '?status=${getTaskStatusFromEnum(taskStatus)}';
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> setTaskPerformer({
    required int performerId,
    required int taskId,
  }) async {
    String url = '$baseUrl/api/provider/task/$taskId/patch_performer/';

    final data = {
      "performer_id": performerId,
    };

    try {
      await apiInstance.patch(url, data: data);
      return;
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> updateTaskStatus({
    required String taskStatus,
    required int taskId,
  }) async {
    String url = '$baseUrl/api/provider/task/$taskId/patch_status/';

    final data = {
      "status": taskStatus,
    };

    try {
      await apiInstance.patch(url, data: data);
      return;
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskReviewListModel> getTaskPerformerReview(
      {required int id, String? previous, String? next}) async {
    String url = '$baseUrl/api/task/review/list?performer=$id';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskReviewListModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskReviewListModel> getTaskProviderReview(
      {required int id, String? previous, String? next}) async {
    String url = '$baseUrl/api/task/review/list?provider=$id';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskReviewListModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> easyApplyTask({
    required int performerId,
    required int taskId,
    String? description,
  }) async {
    String url = '$baseUrl/api/taskapplicant/create/';

    final data = {
      "performer": performerId,
      "task": taskId,
      "description": description,
    };

    try {
      final response = await apiInstance.post(url, data: data);
      if (response.statusCode != 200) {
        throw Failure(
          response.data['error_message'] ?? 'Something went wrong.',
        );
      }
      return;
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskListResponseModel> getPerformerTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  }) async {
    String url =
        '$baseUrl/api/taskapplicant/list/?status=${getTaskStatusFromEnum(taskStatus ?? TaskStatusEnum.pending)}';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskModel> setPerformIsDone(int taskId) async {
    String url = '$baseUrl/api/performer/task/$taskId/patch_is_done_perform/';

    final data = {
      "is_done_perform": true,
    };

    try {
      final response = await apiInstance.patch(url, data: data);
      return TaskModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskShortReviewModel> performerReview({
    required int rate,
    required String feedback,
    required int taskId,
  }) async {
    String url = '$baseUrl/api/task/$taskId/review/';

    final data = {
      "performer_rate": rate,
      "performer_feedback": feedback,
    };

    try {
      final response = await apiInstance.post(url, data: data);
      return TaskShortReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<TaskShortReviewModel> providerReview({
    required int rate,
    required String feedback,
    required int taskId,
  }) async {
    String url = '$baseUrl/api/task/$taskId/review/';

    final data = {
      "provider_rate": rate,
      "provider_feedback": feedback,
    };

    try {
      final response = await apiInstance.post(url, data: data);
      return TaskShortReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
