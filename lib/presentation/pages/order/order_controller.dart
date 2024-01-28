import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/customer_order_model.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class OrderController extends GetxController with ServiceMixin {
  final TextEditingController phoneSearchController = TextEditingController();

  final Rx<LoadingState> loadingState = LoadingState.initial.obs;
  final RxList<CustomerOrderModel> customerOrders = RxList<CustomerOrderModel>([]);
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      return;
    }
    loadingState.value = LoadingState.loading;
    try {
      final result = CustomerOrderModel.mockData(
        keyword: phoneSearchController.text,
      );
      await Future.delayed(const Duration(seconds: 2));
      if (result.isEmpty) {
        loadingState.value = LoadingState.empty;
        return;
      }
      customerOrders.value = result;
      loadingState.value = LoadingState.success;
    } catch (e) {
      loadingState.value = LoadingState.error;
    }
  }
}
