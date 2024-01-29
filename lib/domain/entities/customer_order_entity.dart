import 'package:instrument_store_mobile/core/utils/string_ext.dart';

import 'bases/base_entity.dart';
import 'order_item_entity.dart';

class CustomerOrderEntity extends BaseEntity {
  final int? id;
  final String? customerName;
  final String? deliveryAddress;
  final String? phoneNumber;
  final DateTime? orderTime;
  final double? totalPrice;
  final List<OrderItemEntity>? orderItems;
  CustomerOrderEntity({
    required this.id,
    required this.customerName,
    required this.deliveryAddress,
    required this.phoneNumber,
    required this.orderTime,
    required this.totalPrice,
    required this.orderItems,
  });

  factory CustomerOrderEntity.fromJson(Map<String, dynamic> json) {
    return CustomerOrderEntity(
      id: json['id'],
      customerName: json['customer_name'],
      deliveryAddress: json['delivery_address'],
      phoneNumber: json['phone_number'],
      orderTime: json['order_time']?.toString().toFormatDateTime(),
      totalPrice: json['total_price'],
      orderItems: List<OrderItemEntity>.from(
        json['order_items'].map(
          (x) => OrderItemEntity.fromJson(x),
        ),
      ),
    );
  }
}
