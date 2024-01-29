import 'bases/base_entity.dart';

class OrderItemEntity extends BaseEntity {
  final String? instrumentName;
  final int? quantity;
  final double? price;
  OrderItemEntity({
    required this.instrumentName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    return OrderItemEntity(
      instrumentName: json['instrument_name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
