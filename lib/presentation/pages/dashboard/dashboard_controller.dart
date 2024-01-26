import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/models/category_model.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class DashboardController extends GetxController
    with ServiceMixin, StateMixin<List<CategoryModel>> {
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      change([], status: RxStatus.loading());
      final categories = CategoryModel.mockData();
      await Future.delayed(const Duration(seconds: 2));
      change(categories, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }
}
