import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrument_store_mobile/core/utils/double_ext.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';
import 'package:instrument_store_mobile/presentation/widgets/background_wrapper.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';

import 'cart_controller.dart';
import 'view_models/cart_view_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          body: BackgroundWrapper(
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: context.mediaQuery.size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Get.back();
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Cart',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () {
                          if (controller.cartViewModel.value.isEmpty) {
                            return Center(
                              child: EmptyHandleWidget(
                                title: 'Your cart is empty',
                                content: 'Add some items to your cart',
                                onRetry: () => Get.back(),
                                retryText: 'Go back',
                              ),
                            );
                          }
                          return const AnimatedSize(
                            duration: Duration(milliseconds: 210),
                            child: _HasItemInCart(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () {
              if (controller.cartViewModel.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return FadeInUp(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 210),
                  child: _CheckoutSection(
                    totalPrice: controller.cartViewModel.value.fold<double>(
                      0,
                      (previousValue, element) =>
                          previousValue +
                          element.quantity * element.instrumentItem.price,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _HasItemInCart extends GetView<CartController> {
  const _HasItemInCart();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: controller.cartViewModel.value.length,
        itemBuilder: (context, index) {
          return Obx(
            () => _CartItem(
              item: controller.cartViewModel.value[index].instrumentItem,
              quantity: controller.cartViewModel.value[index].quantity,
              totalPriceOnItem: controller.cartViewModel.value[index].quantity *
                  controller.cartViewModel.value[index].instrumentItem.price,
              onRemove: (item) => controller.deleteItem(
                CartItem.unit(instrumentItem: item),
              ),
              onIncrement: (item) => controller.incrementItem(
                CartItem.unit(instrumentItem: item),
              ),
              onDecrement: (item) => controller.decrementItem(
                CartItem.unit(instrumentItem: item),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CartItem extends GetView<CartController> {
  const _CartItem({
    required this.item,
    required this.quantity,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
    required this.totalPriceOnItem,
  });

  final InstrumentItemModel item;
  final int quantity;
  final Function(InstrumentItemModel) onRemove;
  final Function(InstrumentItemModel) onIncrement;
  final Function(InstrumentItemModel) onDecrement;
  final double totalPriceOnItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minHeight: 100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.theme.colorScheme.onSurface.withOpacity(.2),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
                        color: context.theme.colorScheme.surfaceVariant,
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
                    bottom: -20,
                    right: -20,
                    width: 120,
                    child: Image.asset(
                      item.image,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                        height: 80,
                        width: 80,
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 210),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => onDecrement.call(item),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 210),
                        reverseDuration: Duration.zero,
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          quantity.toString(),
                          key: ValueKey('${item.id}_$quantity'),
                          style: context.theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () => onIncrement.call(item),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Text(
                        'U.Price: ',
                        style: context.theme.textTheme.labelMedium,
                      ),
                      Text(
                        item.price.toPrice(),
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: Colors.amber.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedSize(
                  duration: const Duration(milliseconds: 210),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Price: ',
                        style: context.theme.textTheme.labelMedium,
                      ),
                      const SizedBox(width: 8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 210),
                        reverseDuration: const Duration(milliseconds: 210),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, .5),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          totalPriceOnItem.toPrice(),
                          key: ValueKey('${item.id}_$totalPriceOnItem'),
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            color: context.theme.colorScheme.primary,
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
          InkWell(
            onTap: () => onRemove.call(item),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                size: 24,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutSection extends GetView<CartController> {
  const _CheckoutSection({
    required this.totalPrice,
  });
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mediaQuery.size.height * .1,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 210),
                reverseDuration: const Duration(milliseconds: 210),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  totalPrice.toPrice(),
                  key: ValueKey(totalPrice),
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    color: context.theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    shadows: [
                      BoxShadow(
                        color:
                            context.theme.colorScheme.onSurface.withOpacity(.2),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => controller.showCheckoutDialog(),
            icon: Icon(
              Icons.payment,
              color: context.theme.colorScheme.onPrimary,
            ),
            label: Text(
              'Checkout',
              style: context.theme.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
