import '../bases/base_get_query.dart';

class GetCustomerOrdersQuery extends BaseGetQuery {
  final String? phoneNumber;
  GetCustomerOrdersQuery({
    required this.phoneNumber,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (phoneNumber != null) 'phone_number': phoneNumber,
    };
  }
}
