import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/customer_order_model.dart';
import 'package:instrument_store_mobile/domain/requests/customer_order/get_customer_orders_query.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

class OrderController extends GetxController with ServiceMixin {
  final TextEditingController phoneSearchController = TextEditingController();

  final Rx<LoadingState> loadingState = LoadingState.initial.obs;
  final RxList<CustomerOrderModel> customerOrders =
      RxList<CustomerOrderModel>([]);

  Future<void> search(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      return;
    }
    loadingState.value = LoadingState.loading;
    try {
      final result = await serviceFactory.customerOrderService.get(
        GetCustomerOrdersQuery(
          phoneNumber: phoneNumber,
        ),
      );
      // CustomerOrderModel.mockData(
      //   keyword: phoneSearchController.text,
      // );
      await Future.delayed(const Duration(seconds: 2));
      if (result.isEmpty) {
        loadingState.value = LoadingState.empty;
        return;
      }
      customerOrders.value = result;
      loadingState.value = LoadingState.success;
    } catch (e) {
      log(e.toString(), name: 'OrderController.search');
      loadingState.value = LoadingState.error;
    }
  }
}
