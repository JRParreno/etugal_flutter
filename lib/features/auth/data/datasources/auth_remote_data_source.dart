import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/interceptor/api_interceptor.dart';
import 'package:etugal_flutter/features/auth/data/models/index.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<SignupResponseModel> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String gender,
    required String contactNumber,
    required String address,
    required String birthdate,
  });

  Future<UserModel> currentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio = Dio();
  final apiInstance = ApiInterceptor.apiInstance();

  @override
  Future<LoginResponseModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      String url = '${Env.apiURL}/o/login/';
      Map<String, dynamic> data = {
        'username': email,
        'password': password,
        'grant_type': 'password',
        'client_id': Env.clientId,
        'client_secret': Env.clientSecret
      };

      final response = await dio.post(url, data: data);
      return LoginResponseModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_description'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SignupResponseModel> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String gender,
    required String contactNumber,
    required String address,
    required String birthdate,
  }) async {
    try {
      String url = '${Env.apiURL}/api/signup';
      Map<String, dynamic> data = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'gender': gender,
        'contact_number': contactNumber,
        'address': address,
        'birthdate': birthdate,
      };

      final response = await dio.post(url, data: data);
      return SignupResponseModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      String url = '${Env.apiURL}/api/profile';

      final response = await apiInstance.get(url);
      return UserModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
