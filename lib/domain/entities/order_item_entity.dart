import 'bases/base_entity.dart';

class OrderItemEntity extends BaseEntity {
  OrderItemEntity();

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    return OrderItemEntity();
  }
}
