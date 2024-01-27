import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cart_controller.dart';

class CartCountBadgeWrapper extends GetView<CartController> {
  final Widget child;
  const CartCountBadgeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final cartItems = controller.cartViewModel.cartItems;
        final cartItemsCount = cartItems.fold<int>(
          0,
          (previousValue, element) => previousValue + element.quantity,
        );
        return Stack(
          children: [
            child,
            if (cartItemsCount > 0)
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
                    cartItemsCount.toString(),
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
