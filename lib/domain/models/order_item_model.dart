import 'package:instrument_store_mobile/domain/entities/order_item_entity.dart';

import 'bases/base_model.dart';

class OrderItemModel extends BaseModel {
  final String instrumentName;
  final int quantity;
  final double price;
  const OrderItemModel({
    required this.instrumentName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return const OrderItemModel(
      instrumentName: "",
      quantity: 0,
      price: 0,
    );
  }
}
