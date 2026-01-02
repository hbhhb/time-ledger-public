import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';

abstract interface class CategoryRepository {
  Stream<List<CategoryEntity>> watchAllCategories();
  Future<List<CategoryEntity>> getAllCategories();
  Future<CategoryEntity?> getCategoryById(String id);
  Future<void> createCategory(CategoryEntity category);
  Future<void> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);
}

abstract interface class LogRepository {
  Stream<List<LogEntity>> watchLogsByDate(DateTime date);
  Stream<List<LogEntity>> watchLogsInRange(DateTime startDate, DateTime endDate);
  Future<List<LogEntity>> getLogsByDate(DateTime date);
  Future<void> createLog(LogEntity log);
  Future<void> updateLog(LogEntity log);
  Future<void> deleteLog(String id);
  Future<void> updateLogSnapshots(String categoryId, {required TimeValue newValue});
  Future<void> unlinkLogsByCategoryId(String categoryId);
  Future<void> deleteLogsByCategoryId(String categoryId);
}
