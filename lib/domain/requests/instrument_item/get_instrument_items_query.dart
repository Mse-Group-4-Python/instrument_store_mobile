import '../bases/base_get_query.dart';

class GetInstrumentItemsQuery extends BaseGetQuery {
  GetInstrumentItemsQuery({
    required this.categoryId,
    required this.manufacturerId,
    required this.instrumentId,
    required this.tag,
  });

  final int? categoryId;
  final int? manufacturerId;
  final int? instrumentId;
  final String? tag;
  @override
  Map<String, dynamic> toJson() {
    return {
      if (categoryId != null) 'category_id': categoryId,
      if (manufacturerId != null) 'manufacturer_id': manufacturerId,
      if (instrumentId != null) 'instrument_id': instrumentId,
      if (tag != null) 'tag': tag,
    };
  }
}
