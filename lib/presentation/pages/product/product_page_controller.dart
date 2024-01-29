import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';
import 'package:instrument_store_mobile/domain/requests/instrument_item/get_instrument_items_query.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';
import 'package:instrument_store_mobile/presentation/pages/cart/cart_controller.dart';
import 'package:instrument_store_mobile/presentation/pages/cart/view_models/cart_view_model.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/view_models/product_filter_view_model.dart';

class ProductPageController extends GetxController with ServiceMixin {
  final ProductFilterViewModel? initialFilter;
  final String? initialSearchKeyword;

  ProductPageController({
    required this.initialSearchKeyword,
    required this.initialFilter,
  });

  final _instrumentItemModels = RxList<InstrumentItemModel>([]);

  List<InstrumentItemModel> get instrumentItemModels => _instrumentItemModels;

  final _loadingState = Rx<LoadingState>(LoadingState.initial);
  LoadingState get loadingState => _loadingState.value;

  late final TextEditingController searchController = TextEditingController(
    text: initialSearchKeyword,
  );

  @override
  void onInit() {
    _loadingState.value = LoadingState.loading;
    fetchInstrumentItems();
    super.onInit();
  }

  Future<void> fetchInstrumentItems() async {
    _loadingState.value = LoadingState.loading;
    try {
      final instrumentItems = await serviceFactory.instrumentItemService.get(
        GetInstrumentItemsQuery(
          categoryId: initialFilter?.category?.id,
          manufacturerId: initialFilter?.manufacturer?.id,
          instrumentId: initialFilter?.instrumentId,
          tag: initialFilter?.tag,
        ),
      );
      if (instrumentItems.isEmpty) {
        _loadingState.value = LoadingState.empty;
        return;
      }
      await Future.delayed(const Duration(seconds: 1));
      _instrumentItemModels.value = instrumentItems;
      _loadingState.value = LoadingState.success;
    } catch (e) {
      _loadingState.value = LoadingState.error;
    }
  }

  Future<void> addToCart(
    InstrumentItemModel instrumentItemModel,
  ) async {
    final cartController = Get.find<CartController>();
    cartController.addToCart(
      CartItem(
        instrumentItem: instrumentItemModel,
        quantity: 1,
      ),
    );
  }
}
