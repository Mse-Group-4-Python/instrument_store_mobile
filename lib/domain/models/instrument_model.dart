import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';

class InstrumentModel extends BaseModel {
  const InstrumentModel();

  factory InstrumentModel.fromEntity(InstrumentEntity entity) {
    return const InstrumentModel();
  }
}
