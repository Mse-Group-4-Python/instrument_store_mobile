import 'package:get/get.dart';
import 'package:instrument_store_mobile/domain/services/services.dart';

import 'view_models/cart_view_model.dart';

class CartController extends GetxController with ServiceMixin {
  final Rx<CartViewModel> _cartViewModel = Rx<CartViewModel>(
    const CartViewModel(),
  );

  CartViewModel get cartViewModel => _cartViewModel.value;

  void addToCart(CartItem item) {
    if (cartViewModel.cartItems.contains(item)) {
      final index = cartViewModel.cartItems.indexOf(item);
      final cartItem = cartViewModel.cartItems[index];
      final newCartItem = cartItem.copyWith(
        quantity: () => cartItem.quantity + 1,
      );
      final newCartItems = cartViewModel.cartItems;
      newCartItems[index] = newCartItem;
      _cartViewModel.value = cartViewModel.copyWith(
        cartItems: () => newCartItems,
      );
    } else {
      _cartViewModel.value = cartViewModel.copyWith(
        cartItems: () => [...cartViewModel.cartItems, item],
      );
    }
  }

  void incrementItem(CartItem item) {
    final index = cartViewModel.cartItems.indexOf(item);
    final cartItem = cartViewModel.cartItems[index];
    final newCartItem = cartItem.copyWith(
      quantity: () => cartItem.quantity + 1,
    );
    final newCartItems = cartViewModel.cartItems;
    newCartItems[index] = newCartItem;
    _cartViewModel.value = cartViewModel.copyWith(
      cartItems: () => newCartItems,
    );
  }

  void decrementItem(CartItem item) {
    final index = cartViewModel.cartItems.indexOf(item);
    final cartItem = cartViewModel.cartItems[index];
    final newCartItem = cartItem.copyWith(
      quantity: () => cartItem.quantity - 1,
    );
    final newCartItems = cartViewModel.cartItems;
    newCartItems[index] = newCartItem;
    _cartViewModel.value = cartViewModel.copyWith(
      cartItems: () => newCartItems,
    );
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = cartViewModel.cartItems.indexOf(item);
    final cartItem = cartViewModel.cartItems[index];
    final newCartItem = cartItem.copyWith(
      quantity: () => quantity,
    );
    final newCartItems = cartViewModel.cartItems;
    newCartItems[index] = newCartItem;
    _cartViewModel.value = cartViewModel.copyWith(
      cartItems: () => newCartItems,
    );
  }

  void deleteItem(CartItem item) {
    final newCartItems = cartViewModel.cartItems;
    newCartItems.remove(item);
    _cartViewModel.value = cartViewModel.copyWith(
      cartItems: () => newCartItems,
    );
  }

  void deleteCart() {
    _cartViewModel.value = const CartViewModel();
  }
}
