import 'package:instrument_store_mobile/domain/entities/bases/base_entity.dart';

class OrderStatusEntity extends BaseEntity {
  OrderStatusEntity();

  factory OrderStatusEntity.fromJson(Map<String, dynamic> json) {
    return OrderStatusEntity();
  }
}
