import 'package:instrument_store_mobile/domain/services/services.dart';
import 'package:instrument_store_mobile/infrastructure/clients/dio.dart';

class GlobalBinding {
  const GlobalBinding._internal();

  static GlobalBinding get instance => const GlobalBinding._internal();

  Future<void> init() async {
    DioClient.instance.init(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );
    ServiceFactory.instance.init();
  }
}
