import 'package:instrument_store_mobile/domain/requests/bases/base_get_query.dart';

class GetInstrumentsQuery extends BaseGetQuery {
  final String? search;
  GetInstrumentsQuery({
    required this.search,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'search': search ?? '',
    };
  }
}
