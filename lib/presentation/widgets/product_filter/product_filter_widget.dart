import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/view_models/product_filter_view_model.dart';

import 'product_filter_controller.dart';

class ProductFilterButton extends StatelessWidget {
  final ProductFilterController? controller;
  const ProductFilterButton({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller ?? Get.put(ProductFilterController()),
      builder: (controller) {
        return IconButton.filledTonal(
          style: IconButton.styleFrom(
            minimumSize: const Size(48, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: context.theme.colorScheme.surfaceVariant,
          ),
          onPressed: () async {
            final result = await Get.bottomSheet<ProductFilterViewModel>(
              ProductFilterBottomSheet(controller: controller),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            );
            if (result != null) {
              Get.back(result: result);
            }
          },
          icon: const Icon(Icons.filter_alt),
        );
      },
    );
  }
}

class ProductFilterBottomSheet extends StatelessWidget {
  final ProductFilterController? controller;
  const ProductFilterBottomSheet({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductFilterController>(
      init: controller ?? Get.put(ProductFilterController()),
      builder: (controller) {
        return Container(
          height: Get.height * 0.5,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProductFilterHeader(),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _ProductFilterByCategory(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductFilterHeader extends GetView<ProductFilterController> {
  const _ProductFilterHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('What are you looking for ?',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              )),
        ),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class _ProductFilterByCategory extends GetView<ProductFilterController> {
  const _ProductFilterByCategory();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: controller.categoriesSelection
              .map(
                (category) => const _ProductFilterByCategoryItem(),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ProductFilterCountWrapper extends GetView<ProductFilterController> {
  const ProductFilterCountWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var filterCount = 0;
        if (controller.productFilterViewModel.isHasFilterByCategory) {
          filterCount++;
        }
        if (controller.productFilterViewModel.isHasFilterByManufacturer) {
          filterCount++;
        }

        if (controller.productFilterViewModel.isHasFilterByPrice) {
          filterCount++;
        }
        return Stack(
          children: [
            const Icon(Icons.filter_alt),
            if (filterCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    filterCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ProductFilterByCategoryItem extends StatelessWidget {
  const _ProductFilterByCategoryItem();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
