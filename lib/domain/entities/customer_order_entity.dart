import 'bases/base_entity.dart';

class CustomerOrderEntity extends BaseEntity {
  CustomerOrderEntity();

  factory CustomerOrderEntity.fromJson(Map<String, dynamic> json) {
    return CustomerOrderEntity();
  }
}
