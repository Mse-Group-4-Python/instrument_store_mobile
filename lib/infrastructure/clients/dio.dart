import 'package:dio/dio.dart';
import 'package:instrument_store_mobile/domain/interceptors/log_interceptor.dart';

class DioClient {
  DioClient._internal();

  static final _instance = DioClient._internal();

  static DioClient get instance => _instance;

  void init({
    required String baseUrl,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
      ),
    )..interceptors.addAll(
        [
          DioClientLogger(),
        ],
      );
  }

  late Dio _dio;

  Dio get dio => _dio;
}
