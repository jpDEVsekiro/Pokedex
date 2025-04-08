import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';

class HiveRepository implements IRepository {
  Box? box;

  @override
  Future<void> add(String id, Map entity) async {
    await box?.put(id, entity);
  }

  @override
  Future<void> delete(String id) async {
    if (box?.containsKey(id) ?? false) {
      await box?.delete(id);
    } else {
      throw Exception('Item with id $id not found');
    }
  }

  @override
  Future<void> deleteAll() async {
    if (box != null) {
      await box?.clear();
    } else {
      throw Exception('Box is not initialized');
    }
  }

  @override
  Future<Map?> getById(String id) async {
    return await box?.get(id);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox('cache');
  }
}
