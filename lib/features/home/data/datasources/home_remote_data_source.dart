import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/home/data/models/index.dart';

abstract interface class HomeRemoteDataSource {
  Future<TaskCategoryListResponseModel> getTaskCategoryList({
    String? previous,
    String? next,
    String? search,
  });

  Future<TaskListResponseModel> getTaskList({
    int? taskCategoryId,
    String? previous,
    String? next,
    String? search,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<TaskCategoryListResponseModel> getTaskCategoryList({
    String? previous,
    String? next,
    String? search,
  }) async {
    String url = '$baseUrl/api/task/category/list';

    if (search != null && search.isNotEmpty) {
      url += '?search=$search';
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return TaskCategoryListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskListResponseModel> getTaskList({
    int? taskCategoryId,
    String? previous,
    String? next,
    String? search,
  }) async {
    String url = '$baseUrl/api/task/list';

    if ((taskCategoryId != null && taskCategoryId > 0) &&
        (search != null && search.isNotEmpty)) {
      url += '?search=$search&task_category=$taskCategoryId';
    } else {
      if (search != null && search.isNotEmpty) {
        url += '?search=$search';
      }

      if (taskCategoryId != null && taskCategoryId > 0) {
        url += '?task_category=$taskCategoryId';
      }
    }

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
