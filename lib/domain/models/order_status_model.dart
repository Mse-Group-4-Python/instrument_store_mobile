import 'package:instrument_store_mobile/domain/entities/order_status_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class OrderStatusModel extends BaseModel {
  const OrderStatusModel();

  factory OrderStatusModel.fromEntity(OrderStatusEntity entity) {
    return const OrderStatusModel();
  }
}
