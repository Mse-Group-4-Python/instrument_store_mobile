import 'bases/base_entity.dart';

class InstrumentSearchEntity extends BaseEntity {
  final List<InstrumentEntity>? instruments;
  final List<String>? suggestionKeyword;

  InstrumentSearchEntity({
    required this.instruments,
    required this.suggestionKeyword,
  });

  factory InstrumentSearchEntity.fromJson(Map<String, dynamic> json) {
    return InstrumentSearchEntity(
      instruments: (json['instruments'] as List<dynamic>?)
          ?.map((e) => InstrumentEntity.fromJson(e))
          .toList(),
      suggestionKeyword: (json['suggestionKeyword'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}

class InstrumentEntity extends BaseEntity {
  InstrumentEntity({
    required this.instrumentName,
    required this.manufacturerId,
    required this.manufacturerName,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.color,
    required this.tags,
    required this.id,
  });
  final String? instrumentName;
  final int? manufacturerId;
  final String? manufacturerName;
  final int? categoryId;
  final String? categoryName;
  final String? description;
  final String? color;
  final List<String>? tags;
  final int? id;

  factory InstrumentEntity.fromJson(Map<String, dynamic> json) {
    return InstrumentEntity(
      instrumentName: json['instrument_name'],
      manufacturerId: json['manufacturer_id'],
      manufacturerName: json['manufacturer_name'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      description: json['description'],
      color: json['color'],
      tags: json['tags'] != null
          ? (json['tags'] as List<dynamic>).map((e) => e as String).toList()
          : null,
      id: json['id'],
    );
  }
}
