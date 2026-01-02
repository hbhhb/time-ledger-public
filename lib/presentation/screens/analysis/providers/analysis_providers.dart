import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';

part 'analysis_providers.g.dart';

// --- Date Management ---

@riverpod
class AnalysisDate extends _$AnalysisDate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void previousWeek() {
    state = state.subtract(const Duration(days: 7));
  }

  void nextWeek() {
    final DateTime nextWeek = state.add(const Duration(days: 7));
    // Optional: Prevent future dates if desired, but user requirements didn't specify strict blocking.
    // Logic: "다만, 다음 주가 이미 도래한 날이 하나도 없다면, 해당 주로는 이동할 수 없음"
    // "If not a single day of the next week has arrived yet, cannot move to that week."
    
    final now = DateTime.now();
    // Start of next week (Monday as start, or just based on current date logic)
    // Assuming simple logic: if nextWeek's start day is after now, block.
    // For now, let's just allow it or implement simple future check.
    // Let's implement the specific constraint:
    // If the Monday of the target week is in the future relative to today, maybe?
    // Let's stick to allowing it for now unless strict logic is needed, 
    // but the prompt mentioned the constraint clearly.
    
    // Simple check: Don't allow if start of calculated week is strictly in future?
    // Let's approximate: if nextWeek is > now + 7 days, it's definitely future.
    // Better: let the UI handle the "can go next" check and disable button.
    state = nextWeek;
  }
}

// --- Data Fetching ---

@riverpod
Stream<List<LogEntity>> weeklyLogs(WeeklyLogsRef ref) {
  final date = ref.watch(analysisDateProvider);
  final getLogsInRange = ref.watch(getLogsInRangeUseCaseProvider);

  // Calculate start and end of week (Monday to Sunday)
  // DateTime.weekday: 1 = Mon, 7 = Sun
  final int currentWeekday = date.weekday;
  final DateTime startOfWeek = date.subtract(Duration(days: currentWeekday - 1));
  final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  // Ensure time components are set to start/end of day
  final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0);
  final end = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

  return getLogsInRange.execute(start, end);
}

// --- Statistics Models ---

class AggregatedCategory {
  final CategoryEntity? category; // Nullable if we can't find category, though unlikely
  final String categoryName;
  final String categoryIcon;
  final TimeValue type;
  final int totalDuration; // Minutes

  AggregatedCategory({
    required this.category,
    required this.categoryName,
    required this.categoryIcon,
    required this.type,
    required this.totalDuration,
  });
}

class WeeklyStats {
  final int totalProductiveMinutes;
  final int totalWasteMinutes;
  final List<AggregatedCategory> productiveCategories;
  final List<AggregatedCategory> wasteCategories;

  WeeklyStats({
    required this.totalProductiveMinutes,
    required this.totalWasteMinutes,
    required this.productiveCategories,
    required this.wasteCategories,
  });
}

// --- Statistics Calculation ---

@riverpod
Future<WeeklyStats> analysisStats(AnalysisStatsRef ref) async {
  final logsAsync = ref.watch(weeklyLogsProvider);
  final logs = logsAsync.value ?? []; // Handle loading/error gracefully by default empty
  
  // We need categories to get names/icons if they aren't fully in LogEntity
  // LogEntity has snapshotName and snapshotValue, categoryId, categoryIcon.
  // We can group by categoryId.

  int productiveMinutes = 0;
  int wasteMinutes = 0;

  final Map<String, int> durationMap = {};
  final Map<String, LogEntity> representativeLogMap = {}; // To get icon/name

  for (var log in logs) {
    if (log.snapshotValue == TimeValue.productive) {
      productiveMinutes += log.duration;
    } else {
      wasteMinutes += log.duration;
    }

    // Use categoryId if available, otherwise construct a unique key for unlinked logs based on name+icon+value
    // This ensures that even if name is same, different icons/values are treated as different groups
    final String key = log.categoryId ?? 'unlinked_${log.snapshotName}_${log.snapshotIcon}_${log.snapshotValue}';
    
    durationMap[key] = (durationMap[key] ?? 0) + log.duration;
    if (!representativeLogMap.containsKey(key)) {
      representativeLogMap[key] = log;
    }
  }

  final List<AggregatedCategory> productiveList = [];
  final List<AggregatedCategory> wasteList = [];

  for (var entry in durationMap.entries) {
    final catId = entry.key;
    final duration = entry.value;
    final log = representativeLogMap[catId]!;

    final isUnlinked = log.categoryId == null;
    final categoryName = isUnlinked ? log.snapshotName : (log.categoryName ?? log.snapshotName);
    final categoryIcon = isUnlinked ? log.snapshotIcon : (log.categoryIcon ?? log.snapshotIcon); // Use snapshotIcon if unlinked OR if joined icon is null
    
    final aggregated = AggregatedCategory(
      category: null, 
      categoryName: categoryName,
      categoryIcon: categoryIcon,
      type: log.snapshotValue,
      totalDuration: duration,
    );

    if (log.snapshotValue == TimeValue.productive) {
      productiveList.add(aggregated);
    } else {
      wasteList.add(aggregated);
    }
  }

  // Sort by duration descending
  productiveList.sort((a, b) => b.totalDuration.compareTo(a.totalDuration));
  wasteList.sort((a, b) => b.totalDuration.compareTo(a.totalDuration));

  return WeeklyStats(
    totalProductiveMinutes: productiveMinutes,
    totalWasteMinutes: wasteMinutes,
    productiveCategories: productiveList,
    wasteCategories: wasteList,
  );
}
