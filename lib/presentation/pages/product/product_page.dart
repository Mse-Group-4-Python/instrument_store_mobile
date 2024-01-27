import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/product_filter_controller.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/product_filter_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/view_models/product_filter_view_model.dart';

import 'product_page_controller.dart';

class ProductPage extends StatelessWidget {
  final ProductFilterViewModel? initialFilter;
  final String? initialSearchKeyword;
  const ProductPage({
    required this.initialSearchKeyword,
    required this.initialFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductPageController>(
      init: Get.put(
            ProductPageController(
              initialFilter: initialFilter,
              initialSearchKeyword: initialSearchKeyword,
            ),
          ) ??
          ProductPageController(
            initialSearchKeyword: initialSearchKeyword,
            initialFilter: initialFilter,
          ),
      builder: (controller) {
        return const Scaffold(
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              16,
              32,
              16,
              16,
            ),
            child: Column(
              children: [
                SizedBox(height: 24),
                _SearchAndFilterSection(),
                SizedBox(height: 32),
                _SearchResultSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SearchAndFilterSection extends GetView<ProductPageController> {
  const _SearchAndFilterSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            controller: controller.searchController,
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            autofocus: false,
          ),
        ),
        const SizedBox(width: 8),
        ProductFilterButton(
          controller: ProductFilterController(
            initialFilter: controller.initialFilter,
          ),
        )
      ],
    );
  }
}

class _SearchResultSection extends GetView<ProductPageController> {
  const _SearchResultSection();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadingState) {
        case LoadingState.initial:
        case LoadingState.loading:
          return const LoadingWidget();
        case LoadingState.empty:
          return const EmptyHandleWidget();
        case LoadingState.error:
          return const ErrorHandleWidget();
        case LoadingState.success:
          return const _ListInstrumentItem();
        default:
          return const SizedBox.shrink();
      }
    });
  }
}

class _ListInstrumentItem extends GetView<ProductPageController> {
  const _ListInstrumentItem();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchInstrumentItems();
      },
      child: AnimationLimiter(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: controller.instrumentItemModels.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            final product = controller.instrumentItemModels[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 410),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 410),
                  horizontalOffset: 50,
                  child: Container(
                    clipBehavior: Clip.none,
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 60,
                            maxHeight: 100,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              Positioned.fill(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: context.theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                width: 60,
                                child: Image.asset(
                                  product.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
