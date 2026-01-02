import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_ledger/core/utils/enums.dart';

part 'log_entity.freezed.dart';

@freezed
class LogEntity with _$LogEntity {
  const factory LogEntity({
    required String id,
    required DateTime targetDate,
    required String? categoryId, // Nullable for unlinked logs
    required int duration, // Minutes
    required String snapshotName,
    required String snapshotIcon, // Added for history persistence
    required TimeValue snapshotValue,
    String? categoryIcon, // Joined field
    String? categoryName, // Joined field from Category table
    String? memo,
    required DateTime createdAt,
  }) = _LogEntity;
}
