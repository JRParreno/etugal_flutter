import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/auth/data/models/index.dart';

abstract interface class ProfileRemoteDataSource {
  Future<String> uploadGovernmentId({
    required String userId,
    required String imagePath,
  });
  Future<String> uploadSelfie({
    required String userId,
    required String imagePath,
  });
  Future<String> uploadProfilePhoto({
    required String userId,
    required String imagePath,
  });
  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String birthdate,
    required String contactNumber,
    required String gender,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<UserModel> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String birthdate,
    required String contactNumber,
    required String gender,
  }) async {
    try {
      final data = {
        "user": {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "birthdate": birthdate,
          "contact_number": contactNumber,
          "gender": gender,
          "address": address,
        }
      };

      String url = '$baseUrl/api/profile';

      final response = await apiInstance.patch(url, data: data);
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> uploadGovernmentId(
      {required String userId, required String imagePath}) async {
    String url = '$baseUrl/api/upload-photo/$userId';

    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "id_photo": await MultipartFile.fromFile(imagePath,
            filename: '$dateToday - ${imagePath.split('/').last}'),
      },
    );

    try {
      await apiInstance.put(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
        ),
      );

      return 'Successfully upload ID';
    } on DioException catch (e) {
      throw Failure(
        e.message ?? "Something went wrong",
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> uploadProfilePhoto(
      {required String userId, required String imagePath}) async {
    String url = '$baseUrl/api/upload-photo/$userId';

    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "profile_photo": await MultipartFile.fromFile(imagePath,
            filename: '$dateToday - ${imagePath.split('/').last}'),
      },
    );

    try {
      await apiInstance.put(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
        ),
      );

      return 'Successfully upload profile photo.';
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<String> uploadSelfie(
      {required String userId, required String imagePath}) async {
    String url = '$baseUrl/api/upload-photo/$userId';

    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "face_photo": await MultipartFile.fromFile(imagePath,
            filename: '$dateToday - ${imagePath.split('/').last}'),
      },
    );

    try {
      await apiInstance.put(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
        ),
      );

      return 'Successfully upload selfie photo.';
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
