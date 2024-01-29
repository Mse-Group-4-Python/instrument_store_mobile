import 'bases/base_entity.dart';

class ManufacturerEntity extends BaseEntity {
  final int? manufacturerId;
  final String? manufacturerName;
  ManufacturerEntity({
    required this.manufacturerId,
    required this.manufacturerName,
  });

  factory ManufacturerEntity.fromJson(Map<String, dynamic> json) {
    return ManufacturerEntity(
      manufacturerId: json['manufacturer_id'],
      manufacturerName: json['manufacturer_name'],
    );
  }
}
