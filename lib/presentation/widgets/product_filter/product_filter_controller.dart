import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/models/manufacturer_model.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

import 'view_models/product_filter_view_model.dart';

class ProductFilterController extends GetxController with ServiceMixin {
  final ProductFilterViewModel? initialFilter;

  ProductFilterController({
    this.initialFilter,
  });

  late final _productFilterViewModel = Rx<ProductFilterViewModel>(
    initialFilter ?? ProductFilterViewModel.initial(),
  );
  ProductFilterViewModel get productFilterViewModel =>
      _productFilterViewModel.value;

  final _categoriesSelection = RxList<CategoryModel>([]);
  final _categoryLoadingState = Rx<LoadingState>(LoadingState.initial);
  List<CategoryModel> get categoriesSelection => _categoriesSelection;
  LoadingState get categoryLoadingState => _categoryLoadingState.value;

  final _manufacturersSelection = RxList<ManufacturerModel>([]);
  final _manufacturerLoadingState = Rx<LoadingState>(LoadingState.initial);
  List<ManufacturerModel> get manufacturersSelection => _manufacturersSelection;
  LoadingState get manufacturerLoadingState => _manufacturerLoadingState.value;

  @override
  void onInit() {
    _fetchCategories();
    _fetchManufacturers();
    super.onInit();
  }

  Future<void> _fetchCategories() async {
    try {
      _categoryLoadingState.value = LoadingState.loading;
      final categories = CategoryModel.mockData();
      // await categoryService.getAllCategories();
      _categoriesSelection.value = categories;
      _categoryLoadingState.value = LoadingState.success;
    } catch (e) {
      _categoryLoadingState.value = LoadingState.error;
    }
  }

  Future<void> _fetchManufacturers() async {
    try {
      _manufacturerLoadingState.value = LoadingState.loading;
      final manufacturers = ManufacturerModel.mockData();
      // await manufacturerService.getAllManufacturers();
      _manufacturersSelection.value = manufacturers;
      _manufacturerLoadingState.value = LoadingState.success;
    } catch (e) {
      _manufacturerLoadingState.value = LoadingState.error;
    }
  }

  void updateKeyword(String keyword) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      keyword: () => keyword,
    );
  }

  void updateMinPrice(double minPrice) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      minPrice: () => minPrice,
    );
  }

  void updateMaxPrice(double maxPrice) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      maxPrice: () => maxPrice,
    );
  }

  void updateSortBy(String sortBy) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      sortBy: () => sortBy,
    );
  }

  void updateSortType(String sortType) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      sortType: () => sortType,
    );
  }

  void updateCategory(CategoryModel category) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      category: () => category,
    );
  }

  void updateManufacturer(ManufacturerModel manufacturer) {
    _productFilterViewModel.value = productFilterViewModel.copyWith(
      manufacturer: () => manufacturer,
    );
  }

  void reset() {
    _productFilterViewModel.value.reset();
  }
}
