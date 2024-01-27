import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_page_controller.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductPageController>(
      init: Get.put(ProductPageController()) ?? ProductPageController(),
      builder: (controller) {
        return const SizedBox.shrink();
      },
    );
  }
}
