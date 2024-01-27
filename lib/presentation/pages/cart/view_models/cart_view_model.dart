// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:instrument_store_mobile/domain/models/instrument_item_model.dart';

class CartItem {
  final InstrumentItemModel instrumentItem;
  final int quantity;

  const CartItem({
    required this.instrumentItem,
    required this.quantity,
  });

  CartItem.unit({
    required this.instrumentItem,
  }) : quantity = 1;

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

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.instrumentItem == instrumentItem && other.quantity == quantity;
  }

  @override
  int get hashCode => instrumentItem.hashCode ^ quantity.hashCode;
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

  @override
  bool operator ==(covariant CartViewModel other) {
    if (identical(this, other)) return true;

    for (var i = 0; i < cartItems.length; i++) {
      if (cartItems[i] != other.cartItems[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => cartItems.hashCode;
}
