// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

import 'view_models/cart_view_model.dart';

class CartController extends GetxController with ServiceMixin {
  final Rx<List<CartItem>> cartViewModel = Rx<List<CartItem>>(
    [],
  );

  void addToCart(CartItem item) {
    final itemInCart = cartViewModel.value
        .firstWhereOrNull((e) => e.instrumentItem.id == item.instrumentItem.id);
    if (itemInCart != null) {
      incrementItem(itemInCart);
    } else {
      cartViewModel.value = [...cartViewModel.value, item];
    }
    cartViewModel.refresh();
  }

  void incrementItem(CartItem item) {
    final itemInCart = cartViewModel.value
        .firstWhereOrNull((e) => e.instrumentItem.id == item.instrumentItem.id);
    if (itemInCart != null) {
      final index = cartViewModel.value.indexOf(itemInCart);
      final cartItem = cartViewModel.value[index];
      final newCartItem = cartItem.copyWith(
        quantity: () => cartItem.quantity + 1,
      );
      final newCartItems = cartViewModel.value;
      newCartItems[index] = newCartItem;
      cartViewModel.refresh();
    }
  }

  void decrementItem(CartItem item) {
    final itemInCart = cartViewModel.value
        .firstWhereOrNull((e) => e.instrumentItem.id == item.instrumentItem.id);
    if (itemInCart != null) {
      if (itemInCart.quantity == 1) {
        deleteItem(itemInCart);
        return;
      }
      final index = cartViewModel.value.indexOf(itemInCart);
      final cartItem = cartViewModel.value[index];
      final newCartItem = cartItem.copyWith(
        quantity: () => cartItem.quantity - 1,
      );
      final newCartItems = cartViewModel;
      newCartItems.value[index] = newCartItem;
      cartViewModel.refresh();
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    final itemInCart = cartViewModel.value
        .firstWhereOrNull((e) => e.instrumentItem.id == item.instrumentItem.id);
    if (itemInCart != null) {
      final index = cartViewModel.value.indexOf(itemInCart);
      final cartItem = cartViewModel.value[index];
      final newCartItem = cartItem.copyWith(
        quantity: () => quantity,
      );
      final newCartItems = cartViewModel;
      newCartItems.value[index] = newCartItem;
      cartViewModel.refresh();
    }
  }

  void deleteItem(CartItem item) {
    cartViewModel.value = cartViewModel.value
        .where(
          (e) => e.instrumentItem.id != item.instrumentItem.id,
        )
        .toList();
    cartViewModel.refresh();
  }

  void deleteCart() {
    cartViewModel.value = [];
  }
}
