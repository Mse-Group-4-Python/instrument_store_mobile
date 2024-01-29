import '../bases/base_post_body.dart';

class PostOrderItemBody extends BasePostBody {
  final int? id;
  final int? quantity;
  PostOrderItemBody({
    required this.id,
    required this.quantity,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (quantity != null) 'quantity': quantity,
    };
  }
}
