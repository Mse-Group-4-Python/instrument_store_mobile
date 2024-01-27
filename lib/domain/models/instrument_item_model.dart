import 'dart:math';

import 'package:instrument_store_mobile/domain/entities/instrument_item_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentItemModel extends BaseModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  const InstrumentItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory InstrumentItemModel.fromEntity(InstrumentItemEntity entity) {
    return const InstrumentItemModel(
      id: 0,
      name: '',
      description: '',
      image: '',
      price: 0,
    );
  }

  static List<InstrumentItemModel> mockData() {
    return List.generate(
      10,
      (index) {
        return InstrumentItemModel(
          id: index,
          name: 'Instrument Item $index',
          description: 'Description $index',
          image: 'https://picsum.photos/200/300?random=$index',
          price: Random().nextDouble(),
        );
      },
    );
  }
}
