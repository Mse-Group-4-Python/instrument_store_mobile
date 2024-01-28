import 'package:instrument_store_mobile/domain/entities/category_entity.dart';

import 'bases/base_model.dart';

class CategoryModel extends BaseModel {
  final int id;
  final String name;
  final String image;
  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    final image = _getImageByEntityName(entity.categoryName ?? '');
    return CategoryModel(
      id: entity.categoryId ?? 0,
      name: entity.categoryName ?? '',
      image: image,
    );
  }

  static List<CategoryModel> mockData() {
    return [
      const CategoryModel(
          id: 1, name: 'Guitar', image: 'assets/guitar_category.png'),
      const CategoryModel(
          id: 2, name: 'Drums', image: 'assets/drum_category.png'),
      const CategoryModel(
          id: 4, name: 'Violin', image: 'assets/violin_category.png'),
      const CategoryModel(
          id: 5, name: 'Saxophone', image: 'assets/saxophone_category.png'),
    ];
  }

  static String _getImageByEntityName(String name) {
    return 'assets/${name.toLowerCase()}_category.png';
  }
}
