import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_ledger/core/utils/enums.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    required String icon,
    required TimeValue defaultValue,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
  }) = _CategoryEntity;
}
