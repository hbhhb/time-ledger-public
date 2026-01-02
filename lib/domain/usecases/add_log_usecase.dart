import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';
import 'package:uuid/uuid.dart';

class AddLogUseCase {
  final CategoryRepository _categoryRepository;
  final LogRepository _logRepository;

  AddLogUseCase(this._categoryRepository, this._logRepository);

  Future<void> execute({
    required DateTime targetDate,
    required String categoryId,
    required int duration,
    String? memo,
  }) async {
    // 1. Fetch Category for Snapshot
    final category = await _categoryRepository.getCategoryById(categoryId);
    if (category == null) {
      throw Exception('Category not found: $categoryId');
    }

    // 2. Create Log Entity with Snapshot Data
    final log = LogEntity(
      id: const Uuid().v4(),
      targetDate: targetDate, // Should ensure time is stripped if needed, or handle in Repo
      categoryId: categoryId,
      duration: duration,
      snapshotName: category.name,
      snapshotIcon: category.icon, // Added
      snapshotValue: category.defaultValue,
      memo: memo,
      createdAt: DateTime.now(),
    );

    // 3. Save
    await _logRepository.createLog(log);
  }
}

// Extension to map names if needed, but here simple mapping
extension CategorySnapshot on dynamic {
  // Since we have CategoryEntity in scope
}

// Just map directly in the code above
// snapshotValue: category.defaultValue
