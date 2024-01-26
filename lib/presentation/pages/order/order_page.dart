import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<OrderController>(
      builder: (controller) {
        return const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
