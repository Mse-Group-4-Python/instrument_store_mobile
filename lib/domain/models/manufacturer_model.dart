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
    return [
      const ManufacturerModel(
        id: 1,
        name: 'Yahama',
      ),
      const ManufacturerModel(
        id: 2,
        name: 'Fender',
      ),
      const ManufacturerModel(
        id: 3,
        name: 'Ibanez',
      ),
      const ManufacturerModel(
        id: 4,
        name: 'Gibson',
      ),
      const ManufacturerModel(
        id: 5,
        name: 'Epiphone',
      ),
      const ManufacturerModel(
        id: 6,
        name: 'Squier',
      ),
      const ManufacturerModel(
        id: 7,
        name: 'PRS',
      ),
      const ManufacturerModel(
        id: 8,
        name: 'Jackson',
      ),
      const ManufacturerModel(
        id: 9,
        name: 'ESP',
      ),
      const ManufacturerModel(
        id: 10,
        name: 'Schecter',
      ),
    ];
  }
}
