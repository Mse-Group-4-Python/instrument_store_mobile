import 'package:instrument_store_mobile/domain/entities/manufacturer_entity.dart';
import 'package:instrument_store_mobile/domain/entities/order_status_entity.dart';

import '../category_entity.dart';
import '../customer_entity.dart';
import '../customer_order_entity.dart';
import '../instrument_entity.dart';
import '../instrument_item_entity.dart';
import '../order_item_entity.dart';

abstract class BaseEntity {
  BaseEntity();

  factory BaseEntity.fromJson(Type type, Map<String, dynamic> json) {
    switch (type) {
      case CategoryEntity:
        return CategoryEntity.fromJson(json);
      case InstrumentEntity:
        return InstrumentEntity.fromJson(json);
      case CustomerEntity:
        return CustomerEntity.fromJson(json);
      case CustomerOrderEntity:
        return CustomerOrderEntity.fromJson(json);
      case InstrumentItemEntity:
        return InstrumentItemEntity.fromJson(json);
      case ManufacturerEntity:
        return ManufacturerEntity.fromJson(json);
      case OrderItemEntity:
        return OrderItemEntity.fromJson(json);
      case OrderStatusEntity:
        return OrderStatusEntity.fromJson(json);
      default:
        throw Exception('Invalid type');
    }
  }
}
