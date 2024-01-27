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
        final cartItemsCount = controller.cartViewModel.value.fold<int>(
          0,
          (previousValue, element) => previousValue + element.quantity,
        );

        return Stack(
          children: [
            child,
            if (cartItemsCount > 0)
              Positioned(
                top: 0,
                right: 4,
                width: 24,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade900,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 210),
                      reverseDuration: Duration.zero,
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      child: Text(
                        cartItemsCount.toString(),
                        key: ValueKey(cartItemsCount),
                        style: context.theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
