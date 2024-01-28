import 'bases/base_entity.dart';

class CategoryEntity extends BaseEntity {
  final int? categoryId;
  final String? categoryName;
  CategoryEntity({
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
}
