import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrument_store_mobile/core/utils/double_ext.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';
import 'package:instrument_store_mobile/presentation/pages/cart/cart_page.dart';
import 'package:instrument_store_mobile/presentation/pages/cart/widgets/cart_count_badge_wrapper.dart';
import 'package:instrument_store_mobile/presentation/widgets/background_wrapper.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/product_filter/view_models/product_filter_view_model.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

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
    return KeyboardDismisser(
      child: GetBuilder<ProductPageController>(
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
          return Scaffold(
            body: const BackgroundWrapper(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    0,
                  ),
                  child: Column(
                    children: [
                      // _SearchAndFilterSection(),
                      Expanded(child: _SearchResultSection()),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: CartCountBadgeWrapper(
              child: FloatingActionButton(
                onPressed: () => Get.to(() => const CartPage()),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchAndFilterSection extends GetView<ProductPageController> {
  const _SearchAndFilterSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: CommonTextField(
              controller: controller.searchController,
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              autofocus: false,
            ),
          ),
          // const SizedBox(width: 8),
          // ProductFilterButton(
          //   controller: ProductFilterController(
          //     initialFilter: controller.initialFilter,
          //   ),
          // )
        ],
      ),
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
          padding: const EdgeInsets.only(bottom: 16, top: 16),
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
                  child: _InstrumentItem(product: product),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InstrumentItem extends GetView<ProductPageController> {
  const _InstrumentItem({
    required this.product,
  });

  final InstrumentItemModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minHeight: 100,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                      maxWidth: 80,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(.2),
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  width: 80,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.name} ${product.description}',
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Color(s): ',
                            style:
                                context.theme.textTheme.bodySmall?.copyWith(),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  product.color,
                                  product.color.withOpacity(.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Brand: ',
                            style:
                                context.theme.textTheme.bodySmall?.copyWith(),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product.manufacturer,
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              product.price.toPrice(),
                              style:
                                  context.theme.textTheme.titleMedium?.copyWith(
                                color: context.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () => controller.addToCart(product),
                          child: Text(
                            'Add to cart',
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
