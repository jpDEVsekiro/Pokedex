abstract class IRepository {
  Future<void> init();
  Future<Map?> getById(String id);
  Future<void> add(String id, Map entity);
  Future<void> delete(String id);
  Future<void> deleteAll();
}
