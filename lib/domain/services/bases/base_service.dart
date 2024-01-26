import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_get_query.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_post_body.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_put_body.dart';

abstract class BaseService<
    IdType,
    Model extends BaseModel,
    GetQuery extends BaseGetQuery,
    PostBody extends BasePostBody,
    PutBody extends BasePutBody> {
  Future<List<Model>> get(GetQuery query);
  Future<Model> getById(IdType id);
  Future<bool> create(PostBody body);
  Future<bool> update(IdType id, PutBody body);
  Future<bool> delete(IdType id);
}
