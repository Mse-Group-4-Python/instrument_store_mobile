import 'package:instrument_store_mobile/domain/entities/instrument_item_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentItemModel extends BaseModel {
  const InstrumentItemModel();

  factory InstrumentItemModel.fromEntity(InstrumentItemEntity entity) {
    return const InstrumentItemModel();
  }
}
