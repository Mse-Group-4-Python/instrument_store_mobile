import 'package:instrument_store_mobile/domain/services/services.dart';
import 'package:instrument_store_mobile/infrastructure/clients/dio.dart';

class GlobalBinding {
  const GlobalBinding._internal();

  static GlobalBinding get instance => const GlobalBinding._internal();

  Future<void> init() async {
    DioClient.instance.init(
      baseUrl: 'http://10.0.2.2:5000',
    );
    ServiceFactory.instance.init();
  }
}
