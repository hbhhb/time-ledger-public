import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time_ledger/core/database/app_database.dart';
import 'package:time_ledger/data/repositories/category_repository_impl.dart';
import 'package:time_ledger/data/repositories/log_repository_impl.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';
import 'package:time_ledger/domain/usecases/add_log_usecase.dart';
import 'package:time_ledger/domain/usecases/get_daily_logs_usecase.dart';
import 'package:time_ledger/domain/usecases/get_logs_in_range_usecase.dart';

part 'providers.g.dart';

// Database Provider
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}

// Repositories
@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftCategoryRepository(db);
}

@Riverpod(keepAlive: true)
LogRepository logRepository(LogRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftLogRepository(db);
}

@riverpod
Stream<List<CategoryEntity>> categoryList(CategoryListRef ref) {
  return ref.watch(categoryRepositoryProvider).watchAllCategories();
}

// UseCases
@riverpod
AddLogUseCase addLogUseCase(AddLogUseCaseRef ref) {
  return AddLogUseCase(
    ref.watch(categoryRepositoryProvider),
    ref.watch(logRepositoryProvider),
  );
}

@riverpod
GetDailyLogsUseCase getDailyLogsUseCase(GetDailyLogsUseCaseRef ref) {
  return GetDailyLogsUseCase(
    ref.watch(logRepositoryProvider),
  );
}

@riverpod
GetLogsInRangeUseCase getLogsInRangeUseCase(GetLogsInRangeUseCaseRef ref) {
  return GetLogsInRangeUseCase(
    ref.watch(logRepositoryProvider),
  );
}
