import 'package:instrument_store_mobile/domain/entities/order_item_entity.dart';

import 'bases/base_model.dart';

class OrderItemModel extends BaseModel {
  const OrderItemModel();

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return const OrderItemModel();
  }
}
