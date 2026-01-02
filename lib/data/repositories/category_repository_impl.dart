import 'package:drift/drift.dart';
import 'package:time_ledger/core/database/app_database.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';

class DriftCategoryRepository implements CategoryRepository {
  final AppDatabase _db;

  DriftCategoryRepository(this._db);

  CategoryEntity _mapToEntity(Category row) {
    return CategoryEntity(
      id: row.id,
      name: row.name,
      icon: row.icon,
      defaultValue: row.defaultValue,
      isActive: row.isActive,
      sortOrder: row.sortOrder,
    );
  }

  @override
  Future<void> createCategory(CategoryEntity category) async {
    await _db.into(_db.categories).insert(
          CategoriesCompanion(
            id: Value(category.id),
            name: Value(category.name),
            icon: Value(category.icon),
            defaultValue: Value(category.defaultValue),
            isActive: Value(category.isActive),
            sortOrder: Value(category.sortOrder),
          ),
        );
  }

  @override
  Future<void> deleteCategory(String id) async {
    await (_db.delete(_db.categories)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final rows = await (_db.select(_db.categories)
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    return rows.map(_mapToEntity).toList();
  }

  @override
  Future<CategoryEntity?> getCategoryById(String id) async {
    final row = await (_db.select(_db.categories)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _mapToEntity(row) : null;
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await (_db.update(_db.categories)..where((tbl) => tbl.id.equals(category.id)))
        .write(
      CategoriesCompanion(
        name: Value(category.name),
        icon: Value(category.icon),
        defaultValue: Value(category.defaultValue),
        isActive: Value(category.isActive),
        sortOrder: Value(category.sortOrder),
      ),
    );
  }

  @override
  Stream<List<CategoryEntity>> watchAllCategories() {
    return (_db.select(_db.categories)
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch()
        .map((rows) => rows.map(_mapToEntity).toList());
  }
}
