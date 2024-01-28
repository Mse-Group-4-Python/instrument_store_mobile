import 'package:instrument_store_mobile/domain/entities/bases/base_entity.dart';
import 'package:instrument_store_mobile/domain/entities/category_entity.dart';
import 'package:instrument_store_mobile/domain/entities/customer_order_entity.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_item_entity.dart';
import 'package:instrument_store_mobile/domain/entities/manufacturer_entity.dart';
import 'package:instrument_store_mobile/domain/entities/order_item_entity.dart';

import '../category_model.dart';
import '../customer_order_model.dart';
import '../instrument_item_model.dart';
import '../instrument_model.dart';
import '../manufacturer_model.dart';
import '../order_item_model.dart';

abstract class BaseModel {
  const BaseModel();

  factory BaseModel.fromEntity(Type type, BaseEntity entity) {
    switch (type) {
      case CategoryEntity:
        return CategoryModel.fromEntity(entity as CategoryEntity);
      case InstrumentEntity:
        return InstrumentModel.fromEntity(entity as InstrumentEntity);
      case CustomerOrderEntity:
        return CustomerOrderModel.fromEntity(entity as CustomerOrderEntity);
      case OrderItemEntity:
        return OrderItemModel.fromEntity(entity as OrderItemEntity);
      case ManufacturerEntity:
        return ManufacturerModel.fromEntity(entity as ManufacturerEntity);
      case InstrumentItemEntity:
        return InstrumentItemModel.fromEntity(entity as InstrumentItemEntity);
      case InstrumentSearchEntity:
        return InstrumentSearchModel.fromEntity(
            entity as InstrumentSearchEntity);
      default:
        throw Exception('Invalid type');
    }
  }
}
