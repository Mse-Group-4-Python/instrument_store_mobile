import 'package:instrument_store_mobile/domain/entities/manufacturer_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class ManufacturerModel extends BaseModel {
  final int id;
  final String name;
  const ManufacturerModel({
    required this.id,
    required this.name,
  });

  factory ManufacturerModel.fromEntity(ManufacturerEntity entity) {
    return const ManufacturerModel(
      id: 0,
      name: '',
    );
  }

  static List<ManufacturerModel> mockData() {
    return List.generate(
      10,
      (index) {
        return ManufacturerModel(
          id: index,
          name: 'Manufacturer $index',
        );
      },
    );
  }
}
