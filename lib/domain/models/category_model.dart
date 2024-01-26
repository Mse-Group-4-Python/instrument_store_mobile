import 'package:instrument_store_mobile/domain/entities/category_entity.dart';

import 'bases/base_model.dart';

class CategoryModel extends BaseModel {
  final int id;
  final String name;
  const CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return const CategoryModel(id: 0, name: '');
  }

  static List<CategoryModel> mockData() {
    return [
      const CategoryModel(id: 1, name: 'Guitar'),
      const CategoryModel(id: 2, name: 'Drum'),
      const CategoryModel(id: 4, name: 'Violin'),
      const CategoryModel(id: 5, name: 'Saxophone'),
    ];
  }

  String get image {
    switch (name.toLowerCase()) {
      case 'guitar':
        return 'assets/guitar_category.png';
      case 'drum':
        return 'assets/drum_category.png';
      case 'violin':
        return 'assets/violin_category.png';
      case 'saxophone':
        return 'assets/saxophone_category.png';
      default:
        return '';
    }
  }
}
