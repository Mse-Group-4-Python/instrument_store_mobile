import 'package:instrument_store_mobile/domain/entities/customer_order_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class CustomerOrderModel extends BaseModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final DateTime orderDate;
  final double totalPrice;
  CustomerOrderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalPrice,
  }) : orderDate = DateTime.now();

  factory CustomerOrderModel.fromEntity(CustomerOrderEntity entity) {
    return CustomerOrderModel(
      id: 0,
      name: '',
      phone: '',
      address: '',
      totalPrice: 0,
    );
  }

  static List<CustomerOrderModel> mockData({required String keyword}) {
    final list = [
      CustomerOrderModel(
        id: 1,
        name: 'Nguyen Van A',
        phone: '0123456789',
        address: 'Ha Noi',
        totalPrice: 1000000,
      ),
      CustomerOrderModel(
        id: 2,
        name: 'Nguyen Van B',
        phone: '0123456789',
        address: 'Ha Noi',
        totalPrice: 1000000,
      ),
      CustomerOrderModel(
        id: 3,
        name: 'Nguyen Van C',
        phone: '0123456789',
        address: 'Ha Noi',
        totalPrice: 1000000,
      ),
      CustomerOrderModel(
        id: 4,
        name: 'Nguyen Van D',
        phone: '0123456789',
        address: 'Ha Noi',
        totalPrice: 1000000,
      ),
    ];
    final filterByPhone = list.where((element) {
      final condition = element.phone.contains(keyword);
      return condition;
    }).toList();
    return filterByPhone;
  }
}
