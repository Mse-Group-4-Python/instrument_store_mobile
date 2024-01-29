import 'package:instrument_store_mobile/domain/requests/order_item/post_order_item_body.dart';

import '../bases/base_post_body.dart';

class PostCustomerOrderBody extends BasePostBody {
  final String? customerName;
  final String? deliveryAddress;
  final String? phoneNumber;
  final List<PostOrderItemBody>? orderItems;
  PostCustomerOrderBody({
    required this.customerName,
    required this.deliveryAddress,
    required this.phoneNumber,
    required this.orderItems,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (customerName != null) 'customer_name': customerName,
      if (deliveryAddress != null) 'delivery_address': deliveryAddress,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (orderItems?.isNotEmpty == true)
        'orders': orderItems?.map((e) => e.toJson()).toList(),
    };
  }
}
