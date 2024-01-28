import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/requests/category/get_categories_query.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class DashboardController extends GetxController
    with ServiceMixin, StateMixin<List<CategoryModel>> {
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      change([], status: RxStatus.loading());
      final categories = await serviceFactory.categoryService.get(
        GetCategoriesQuery(),
      );
      await Future.delayed(const Duration(seconds: 2));
      change(categories, status: RxStatus.success());
    } catch (e, stackTrace) {
      log(
        e.toString(),
        name: 'DashboardController_loadCategories()',
        stackTrace: stackTrace,
      );
      change([], status: RxStatus.error(e.toString()));
    }
  }
}
