import 'package:instrument_store_mobile/domain/entities/customer_order_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';
import 'dart:developer';

import 'package:instrument_store_mobile/domain/models/order_item_model.dart';

class CustomerOrderModel extends BaseModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final DateTime orderDate;
  final double totalPrice;
  final List<OrderItemModel> orderItems;
  CustomerOrderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalPrice,
    this.orderItems = const [],
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
    final customerOrderModelList = [
      CustomerOrderModel(
        id: 1,
        name: 'Huynh Le Hong Phuc',
        phone: '1111111111',
        address: 'Ha Noi',
        totalPrice: 1000000,
        orderItems: const [
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 9,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
        ],
      ),
      CustomerOrderModel(
        id: 2,
        name: 'Do Duong Tam Dang',
        phone: '1111111122',
        address: 'Ha Noi',
        totalPrice: 1000000,
        orderItems: const [
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Piano',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Sax',
            quantity: 1,
            price: 1000000,
          ),
        ],
      ),
      CustomerOrderModel(
        id: 3,
        name: 'Nguyen Van C',
        phone: '3333333333',
        address: 'Ha Noi',
        totalPrice: 1000000,
        orderItems: const [
          OrderItemModel(
            instrumentName: 'Sax',
            quantity: 1,
            price: 1000000,
          ),
        ],
      ),
      CustomerOrderModel(
        id: 4,
        name: 'Nguyen Van D',
        phone: '4444444444',
        address: 'Ha Noi',
        totalPrice: 1000000,
        orderItems: const [
          OrderItemModel(
            instrumentName: 'Guitar',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Piano',
            quantity: 1,
            price: 1000000,
          ),
          OrderItemModel(
            instrumentName: 'Sax',
            quantity: 3,
            price: 1000000,
          ),
        ],
      ),
    ];
    final filterByPhone = customerOrderModelList.where((element) {
      final resultFilter = element.phone == keyword;
      final condition = resultFilter;
      return condition;
    }).toList();
    return filterByPhone;
  }
}
