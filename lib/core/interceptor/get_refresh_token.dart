import 'dart:async';

import 'package:dio/dio.dart';
import 'package:etugal_flutter/core/env/env.dart';

class GetRefreshToken {
  static FutureOr refreshToken({required String refreshToken}) async {
    String url = '${Env.apiURL}/o/token/';
    Map<String, dynamic> data = {
      'refresh_token': refreshToken,
      'grant_type': 'refresh_token',
      'client_id': Env.clientId,
      'client_secret': Env.clientSecret
    };
    final Dio dio = Dio();
    final userDetails = await dio.post(url, data: data);

    if (userDetails.statusCode == 400) {
      return {'statusCode': userDetails.statusCode, 'data': userDetails.data};
    }

    Map<String, dynamic> responseJson = userDetails.data;
    return {
      'accessToken': responseJson['access_token'],
      'refreshToken': responseJson['refresh_token'],
      'statusCode': userDetails.statusCode,
    };
  }
}
