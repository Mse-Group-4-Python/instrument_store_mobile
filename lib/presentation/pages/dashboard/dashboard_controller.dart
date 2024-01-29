import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/models/manufacturer_model.dart';
import 'package:instrument_store_mobile/domain/requests/category/get_categories_query.dart';
import 'package:instrument_store_mobile/domain/requests/manufacturer/get_manufacturers_query.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class DashboardController extends GetxController with ServiceMixin {
  final TextEditingController searchController = TextEditingController();
  final categories = RxList<CategoryModel>([]);
  final categoryLoadingState = Rx<LoadingState>(LoadingState.initial);

  final manufacturers = RxList<ManufacturerModel>([]);
  final manufacturerLoadingState = Rx<LoadingState>(LoadingState.initial);

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadManufacturers();
  }

  Future<void> loadCategories() async {
    try {
      categoryLoadingState.call(LoadingState.loading);
      final data = await serviceFactory.categoryService.get(
        GetCategoriesQuery(),
      );
      if (data.isEmpty) {
        categoryLoadingState.call(LoadingState.empty);
        return;
      } else {
        categoryLoadingState.call(LoadingState.success);
      }
      categories.call(data);
    } catch (e, stackTrace) {
      log(
        e.toString(),
        name: 'DashboardController_loadCategories()',
        stackTrace: stackTrace,
      );
      categoryLoadingState.call(LoadingState.error);
    }
  }

  Future<void> loadManufacturers() async {
    try {
      manufacturerLoadingState.call(LoadingState.loading);
      final data = await serviceFactory.manufacturerService.get(
        GetManufacturersQuery(),
      );
      if (data.isEmpty) {
        manufacturerLoadingState.call(LoadingState.empty);
        return;
      } else {
        manufacturerLoadingState.call(LoadingState.success);
      }
      manufacturers.call(data);
    } catch (e, stackTrace) {
      log(
        e.toString(),
        name: 'DashboardController_loadManufacturers()',
        stackTrace: stackTrace,
      );
      manufacturerLoadingState.call(LoadingState.error);
    }
  }
}
