// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/core/utils/datetime_ext.dart';
import 'package:instrument_store_mobile/core/utils/double_ext.dart';
import 'package:instrument_store_mobile/domain/enums/loading_enum.dart';
import 'package:instrument_store_mobile/domain/models/customer_order_model.dart';
import 'package:instrument_store_mobile/presentation/widgets/background_wrapper.dart';
import 'package:instrument_store_mobile/presentation/widgets/common_text_field.dart';
import 'package:instrument_store_mobile/presentation/widgets/empty_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/error_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/loading_widget.dart';
import 'package:instrument_store_mobile/presentation/widgets/search_loading_widget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KeyboardDismisser(
      child: GetBuilder<OrderController>(
        builder: (controller) {
          return const Scaffold(
            body: BackgroundWrapper(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    32,
                    16,
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: _SearchTextField()),
                          const SizedBox(width: 8),
                          _SearchPhoneNumberButton(),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // blank page, when user search -> display result
                      Expanded(child: const _SearchResultSection()),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SearchTextField extends GetView<OrderController> {
  const _SearchTextField();

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      keyboardType: TextInputType.phone,
      controller: controller.phoneSearchController,
      hintText: 'Search by phone number',
      prefixIcon: const Icon(Icons.search_rounded),
      autofocus: true,
    );
  }
}

class _SearchPhoneNumberButton extends GetView<OrderController> {
  const _SearchPhoneNumberButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
        style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: context.theme.colorScheme.surfaceVariant,
        ),
        onPressed: () {
          controller.search(controller.phoneSearchController.text);
        },
        icon: const Icon(Icons.search_rounded));
  }
}

class _SearchResultSection extends GetView<OrderController> {
  const _SearchResultSection();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadingState.value) {
        case LoadingState.initial:
        case LoadingState.loading:
          return const SearchLoadingWidget(text: 'Searching phone number...');
        case LoadingState.success:
          return RefreshIndicator(
            onRefresh: () async {
              controller.search(controller.phoneSearchController.text);
            },
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.customerOrders.length,
                itemBuilder: (context, index) {
                  final order = controller.customerOrders[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: FadeInAnimation(
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 500),
                        child: LayoutBuilder(builder: (
                          context,
                          constraints,
                        ) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                _CustomerOrderItems(
                                  order: order,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        case LoadingState.empty:
          return const EmptyHandleWidget();
        case LoadingState.error:
          return const ErrorHandleWidget();
      }
    });
  }
}

class _CustomerOrderItems extends StatelessWidget {
  const _CustomerOrderItems({super.key, required this.order});
  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 80,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    size: Get.size.width * 0.1,
                    color: Colors.orange.shade800,
                    shadows: [
                      BoxShadow(
                        color: context.theme.colorScheme.onSurface.withOpacity(.1),
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _DetailElementComponent(order: order),
              ],
            ),
            const SizedBox(height: 20),
            _TotalQuantityOrderItem(order: order),
            const SizedBox(height: 16),
            _HorizontalListOrderItems(order: order),
          ],
        ),
      ),
    );
  }
}

class _HorizontalListOrderItems extends StatelessWidget {
  const _HorizontalListOrderItems({super.key, required this.order});
  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AnimationLimiter(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemCount: order.orderItems.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 500),
                  horizontalOffset: 50.0,
                  child: Container(
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.surface.withOpacity(.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: context.theme.colorScheme.onSurface.withOpacity(.1),
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/guitar_category.png',
                            height: 50,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.orderItems[index].instrumentName,
                                    style: context.theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'x${order.orderItems[index].quantity}',
                                    style: context.theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                order.orderItems[index].price.toPrice(),
                                style: context.theme.textTheme.bodyMedium?.copyWith(
                                  color: context.theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TotalQuantityOrderItem extends StatelessWidget {
  const _TotalQuantityOrderItem({super.key, required this.order});
  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final totalQuantity = order.orderItems.fold<int>(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );
      return Align(
        alignment: Alignment.centerLeft,
        child: Text.rich(
          TextSpan(
            text: 'Order items',
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' (${order.orderItems.length})',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' - Total: ',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: totalQuantity.toString(),
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _DetailElementComponent extends StatelessWidget {
  const _DetailElementComponent({super.key, required this.order});
  final CustomerOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.name,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            order.phone,
            style: context.theme.textTheme.titleSmall?.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            order.address,
            style: context.theme.textTheme.titleSmall?.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _CustomerOrderInforSection(
                icon: Icons.receipt_long,
                title: (order.totalPrice).toPrice(),
              ),
              const SizedBox(width: 16),
              _CustomerOrderInforSection(
                icon: Icons.receipt_long,
                title: (order.orderDate).toFormattedString(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CustomerOrderInforSection extends StatelessWidget {
  const _CustomerOrderInforSection({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 25,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: context.theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
