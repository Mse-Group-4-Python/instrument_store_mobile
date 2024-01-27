import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentModel extends BaseModel {
  final int id;
  final String image;
  final String name;
  const InstrumentModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory InstrumentModel.fromEntity(InstrumentEntity entity) {
    return const InstrumentModel(
      id: 0,
      image: '',
      name: '',
    );
  }

  static List<InstrumentModel> mockData({required String name}) {
    final list = [
      const InstrumentModel(
        id: 1,
        image: 'assets/guitar_category.png',
        name: 'Guitar',
      ),
      const InstrumentModel(
        id: 2,
        image: 'assets/drum_category.png',
        name: 'Drum',
      ),
      const InstrumentModel(
        id: 3,
        image: 'assets/violin_category.png',
        name: 'Violin',
      ),
      const InstrumentModel(
        id: 4,
        image: 'assets/saxophone_category.png',
        name: 'Saxophone',
      ),
    ];

    return list.where((element) {
      final filterByName =
          element.name.toLowerCase().contains(name.toLowerCase());
      final condition = filterByName;
      return condition;
    }).toList();
  }
}
