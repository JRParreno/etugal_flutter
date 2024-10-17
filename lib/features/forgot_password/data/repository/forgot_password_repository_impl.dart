import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/features/forgot_password/data/repository/forgot_password_repository.dart';
import 'package:etugal_flutter/features/forgot_password/domain/models/forgot_password_response.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  final baseUrl = Env.apiURL;
  final Dio dio = Dio();

  @override
  Future<ForgotPasswordResponse> sendForgotPasswordEmail({
    required String email,
  }) async {
    String url = '$baseUrl/api/forgot-password';

    Map<String, dynamic> data = {
      'email_address': email,
    };

    return await dio.post(url, data: data).then((value) {
      final result = ForgotPasswordResponse.fromMap(
        value.data as Map<String, dynamic>,
      );

      return result;
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioException;

      if (error.response != null && error.response!.data != null) {
        throw {
          'status': error.response?.statusCode ?? '400',
          'data': error.response!.data,
        };
      }

      throw error;
    });
  }
}
