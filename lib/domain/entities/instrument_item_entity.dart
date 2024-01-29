import 'bases/base_entity.dart';

class InstrumentItemEntity extends BaseEntity {
  InstrumentItemEntity({
    required this.id,
    required this.instrumentId,
    required this.serialNumber,
    required this.description,
    required this.yearOfPurchase,
    required this.price,
    required this.instrumentName,
    required this.color,
    required this.categoryName,
    required this.manufacturerName,
  });

  final int? id;
  final int? instrumentId;
  final String? serialNumber;
  final String? description;
  final int? yearOfPurchase;
  final double? price;
  final String? instrumentName;
  final String? color;
  final String? categoryName;
  final String? manufacturerName;

  factory InstrumentItemEntity.fromJson(Map<String, dynamic> json) {
    return InstrumentItemEntity(
      id: json['id'],
      instrumentId: json['instrument_id'],
      serialNumber: json['serial_number'],
      description: json['description'],
      yearOfPurchase: json['year_of_purchase'],
      price: json['price'],
      instrumentName: json['instrument_name'],
      color: json['color'],
      categoryName: json['category_name'],
      manufacturerName: json['manufacturer_name'],
    );
  }
}
