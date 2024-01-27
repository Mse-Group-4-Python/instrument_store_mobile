import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class ProductPageController extends GetxController with ServiceMixin {
  final _instrumentItemModel = RxList<InstrumentItemModel>([]);

  List<InstrumentItemModel> get instrumentItemModel => _instrumentItemModel;

  final _loadingState = Rx<LoadingState>(LoadingState.initial);
  LoadingState get loadingState => _loadingState.value;

  @override
  void onInit() {
    _loadingState.value = LoadingState.loading;
    _fetchInstrumentItems();
    super.onInit();
  }

  Future<void> _fetchInstrumentItems() async {
    try {
      final instrumentItems = InstrumentItemModel.mockData();
      _instrumentItemModel.value = instrumentItems;
      _loadingState.value = LoadingState.success;
    } catch (e) {
      _loadingState.value = LoadingState.error;
    }
  }
}
