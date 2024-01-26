import 'package:instrument_store_mobile/domain/entities/bases/base_entity.dart';
import 'package:instrument_store_mobile/domain/entities/category_entity.dart';
import 'package:instrument_store_mobile/domain/entities/instrument_entity.dart';

import '../category_model.dart';
import '../instrument_model.dart';

abstract class BaseModel {
  const BaseModel();

  factory BaseModel.fromEntity(Type type, BaseEntity entity) {
    switch (type) {
      case CategoryModel:
        return CategoryModel.fromEntity(entity as CategoryEntity);
      case InstrumentModel:
        return InstrumentModel.fromEntity(entity as InstrumentEntity);
      default:
        throw Exception('Invalid type');
    }
  }
}
