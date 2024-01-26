import 'package:dio/dio.dart';

class DioClientLogger extends LogInterceptor {
  DioClientLogger()
      : super(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
          error: true,
          request: true,
        );
}
