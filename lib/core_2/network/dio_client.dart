import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_interceptors.dart';
import '../constants/constants.dart';

class DioClient {
  static Dio createDioClient({String? baseUrl, String? accessToken}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: Duration(seconds: ApiConstants.connectionTimeout),
        receiveTimeout: Duration(seconds: ApiConstants.receiveTimeout),
        sendTimeout: Duration(seconds: ApiConstants.sendTimeout),
        contentType: ApiConstants.contentTypeJson,
        headers: {
          'Content-Type': ApiConstants.contentTypeJson,
          if (accessToken != null)
            ApiConstants.authorizationHeader:
                '${ApiConstants.bearerPrefix} $accessToken',
        },
      ),
    );

    // Add interceptors
    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }

    dio.interceptors.add(AuthorizationInterceptor(accessToken: accessToken));
    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }
}
