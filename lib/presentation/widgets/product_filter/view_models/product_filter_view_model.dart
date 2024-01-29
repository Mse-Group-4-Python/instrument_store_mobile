import 'package:flutter/material.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/models/manufacturer_model.dart';

class ProductFilterViewModel {
  final String? keyword;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final String? sortType;
  final CategoryModel? category;
  final ManufacturerModel? manufacturer;
  final int? instrumentId;

  const ProductFilterViewModel({
    required this.keyword,
    required this.minPrice,
    required this.maxPrice,
    required this.sortBy,
    required this.sortType,
    required this.category,
    required this.manufacturer,
    required this.instrumentId,
  });

  factory ProductFilterViewModel.initial() {
    return const ProductFilterViewModel(
      keyword: null,
      minPrice: null,
      maxPrice: null,
      sortBy: null,
      sortType: null,
      category: null,
      manufacturer: null,
      instrumentId: null,
    );
  }

  ProductFilterViewModel copyWith({
    ValueGetter<String?>? keyword,
    ValueGetter<double?>? minPrice,
    ValueGetter<double?>? maxPrice,
    ValueGetter<String?>? sortBy,
    ValueGetter<String?>? sortType,
    ValueGetter<CategoryModel?>? category,
    ValueGetter<ManufacturerModel?>? manufacturer,
    ValueGetter<int?>? instrumentId,
  }) {
    return ProductFilterViewModel(
      keyword: keyword != null ? keyword() : this.keyword,
      minPrice: minPrice != null ? minPrice() : this.minPrice,
      maxPrice: maxPrice != null ? maxPrice() : this.maxPrice,
      sortBy: sortBy != null ? sortBy() : this.sortBy,
      sortType: sortType != null ? sortType() : this.sortType,
      category: category != null ? category() : this.category,
      manufacturer: manufacturer != null ? manufacturer() : this.manufacturer,
      instrumentId: instrumentId != null ? instrumentId() : this.instrumentId,
    );
  }

  void reset() {
    copyWith(
      keyword: () => null,
      minPrice: () => null,
      maxPrice: () => null,
      sortBy: () => null,
      sortType: () => null,
      category: () => null,
      manufacturer: () => null,
    );
  }

  bool get isHasFilterByKeyword => keyword?.isNotEmpty == true;

  bool get isHasFilterByPrice => minPrice != null || maxPrice != null;

  bool get isHasFilterByCategory => category != null;

  bool get isHasFilterByManufacturer => manufacturer != null;

  bool get isHasFilter =>
      isHasFilterByKeyword ||
      isHasFilterByPrice ||
      isHasFilterByCategory ||
      isHasFilterByManufacturer;
}
