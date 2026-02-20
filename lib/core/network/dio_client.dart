import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresshi/core/constants/api_constants.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';

class DioClient with NetworkLoggy {
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

    // Only add logging interceptor in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        LoggyDioInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}

/// Mixin for network layer logging.
mixin NetworkLoggy implements LoggyType {
  @override
  Loggy<NetworkLoggy> get loggy => Loggy<NetworkLoggy>('NETWORK - $runtimeType');
}
