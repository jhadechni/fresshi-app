import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresshi/core/constants/api_constants.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (log) => debugPrint(log.toString()),
      ),
    ]);

    return dio;
  }
}
