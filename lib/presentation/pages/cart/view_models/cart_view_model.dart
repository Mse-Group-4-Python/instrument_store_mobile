import 'package:flutter/material.dart';
import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';

class CartItem {
  final InstrumentItemModel instrumentItem;
  final int quantity;

  const CartItem({
    required this.instrumentItem,
    required this.quantity,
  });

  CartItem copyWith({
    ValueGetter<InstrumentItemModel>? instrumentItem,
    ValueGetter<int>? quantity,
  }) {
    return CartItem(
      instrumentItem:
          instrumentItem != null ? instrumentItem() : this.instrumentItem,
      quantity: quantity != null ? quantity() : this.quantity,
    );
  }
}

class CartViewModel {
  final List<CartItem> cartItems;

  const CartViewModel({
    this.cartItems = const [],
  });

  factory CartViewModel.empty() {
    return const CartViewModel();
  }

  CartViewModel copyWith({
    ValueGetter<List<CartItem>>? cartItems,
  }) {
    return CartViewModel(
      cartItems: cartItems != null ? cartItems() : this.cartItems,
    );
  }
}
