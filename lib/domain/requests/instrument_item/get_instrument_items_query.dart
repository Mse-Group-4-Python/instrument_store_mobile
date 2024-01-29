import '../bases/base_get_query.dart';

class GetInstrumentItemsQuery extends BaseGetQuery {
  GetInstrumentItemsQuery({
    required this.categoryId,
    required this.manufacturerId,
    required this.instrumentId,
  });

  final int? categoryId;
  final int? manufacturerId;
  final int? instrumentId;
  @override
  Map<String, dynamic> toJson() {
    return {
      if (categoryId != null) 'category_id': categoryId,
      if (manufacturerId != null) 'manufacturer_id': manufacturerId,
      if (instrumentId != null) 'instrument_id': instrumentId,
    };
  }
}
