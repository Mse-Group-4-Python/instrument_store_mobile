import 'package:dio/dio.dart';
import 'package:instrument_store_mobile/domain/entities/bases/base_entity.dart';
import 'package:instrument_store_mobile/domain/models/bases/base_model.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_get_query.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_post_body.dart';
import 'package:instrument_store_mobile/domain/requests/bases/base_put_body.dart';
import 'package:instrument_store_mobile/domain/services/bases/base_service.dart';
import 'package:instrument_store_mobile/infrastructure/clients/dio.dart';

abstract class BaseRepo<
        IdType,
        Entity extends BaseEntity,
        Model extends BaseModel,
        GetQuery extends BaseGetQuery,
        PostBody extends BasePostBody,
        PutBody extends BasePutBody>
    implements BaseService<IdType, Model, GetQuery, PostBody, PutBody> {
  final Dio _dio;
  final String _path;

  Dio get dio => _dio;
  String get path => _path;

  BaseRepo({
    String? path,
    Dio? dio,
  })  : _path = path ?? '/instruments',
        _dio = dio ?? DioClient.instance.dio;

  @override
  Future<bool> create(PostBody body) async {
    try {
      final result = await _dio.post(
        _path,
        data: body.toJson(),
      );
      if ([200, 201].contains(result.statusCode)) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(IdType id) async {
    try {
      final result = await _dio.delete(
        '$_path/$id',
      );
      if ([200].contains(result.statusCode)) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Model> getById(IdType id) async {
    try {
      final result = await _dio.get(
        '$_path/$id',
      );
      if ([200].contains(result.statusCode)) {
        final entity = BaseEntity.fromJson(Entity, result.data);
        return BaseModel.fromEntity(Entity, entity) as Model;
      }
      throw Exception('Không tìm thấy dữ liệu');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Model>> get(GetQuery query) async {
    try {
      final result = await _dio.get(
        _path,
        queryParameters: query.toJson(),
      );
      if ([200].contains(result.statusCode)) {
        final List<BaseEntity> entities = (result.data as List)
            .map((e) => BaseEntity.fromJson(Entity, e))
            .toList();
        return entities
            .map(
              (e) => BaseModel.fromEntity(Entity, e) as Model,
            )
            .toList();
      }
      throw Exception('Không tìm thấy dữ liệu');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update(IdType id, BasePutBody body) async {
    try {
      final result = await _dio.put(
        '$_path/$id',
        data: body.toJson(),
      );
      if ([200].contains(result.statusCode)) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Model> getToMap(GetQuery query) {
    throw UnimplementedError();
  }
}
