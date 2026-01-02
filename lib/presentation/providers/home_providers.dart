import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';

part 'home_providers.g.dart';

@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime? build() {
    // 1. Get all available logs
    final logsAsync = ref.watch(logListRangeProvider);
    final logs = logsAsync.valueOrNull ?? [];
    
    if (logs.isEmpty) return null;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // 2. Find the date with logs closest to today
    DateTime? closestDate;
    int minDiff = -1;

    for (var log in logs) {
      final logDate = DateTime(log.targetDate.year, log.targetDate.month, log.targetDate.day);
      final diff = (logDate.difference(today).inDays).abs();
      
      if (closestDate == null || diff < minDiff) {
        closestDate = logDate;
        minDiff = diff;
      } else if (diff == minDiff) {
        // If same distance, prefer the one closer to today (if possible) or just pick one
        // Here we just keep the first one found for simplicity
      }
    }

    return closestDate;
  }

  void updateDate(DateTime date) {
    state = date;
  }
}

@riverpod
bool hasLogs(HasLogsRef ref, DateTime date) {
  final grassLevels = ref.watch(grassLevelsProvider);
  final normalizedDate = DateTime(date.year, date.month, date.day);
  return grassLevels.containsKey(normalizedDate);
}

@riverpod
Stream<List<LogEntity>> logListRange(LogListRangeRef ref) {
  // TODO: Optimize this to fetch based on selectedDate if needed later
  final now = DateTime.now();
  final start = now.subtract(const Duration(days: 365 * 2)); // Extend range for safety
  final end = now.add(const Duration(days: 365));
  return ref.watch(getLogsInRangeUseCaseProvider).execute(start, end);
}

@riverpod
bool hasLogsInPreviousMonth(HasLogsInPreviousMonthRef ref) {
  final logsAsync = ref.watch(logListRangeProvider);
  final logs = logsAsync.valueOrNull ?? [];
  final selectedDate = ref.watch(selectedDateProvider);
  if (selectedDate == null) return false;
  
  // Calculate previous month
  final prevMonthDate = DateTime(selectedDate.year, selectedDate.month - 1);
  
  // Check if any log exists in the previous month
  return logs.any((log) => 
    log.targetDate.year == prevMonthDate.year && 
    log.targetDate.month == prevMonthDate.month
  );
}

@riverpod
Map<DateTime, List<LogEntity>> groupedLogs(GroupedLogsRef ref) {
  final logsAsync = ref.watch(logListRangeProvider);
  final logs = logsAsync.valueOrNull ?? [];
  final selectedDate = ref.watch(selectedDateProvider);
  if (selectedDate == null) return {};
  
  final Map<DateTime, List<LogEntity>> grouped = {};
  for (var log in logs) {
    // Filter: Include only logs in the selected month
    if (log.targetDate.year != selectedDate.year || 
        log.targetDate.month != selectedDate.month) {
      continue;
    }

    final dateKey = DateTime(log.targetDate.year, log.targetDate.month, log.targetDate.day);
    if (!grouped.containsKey(dateKey)) {
      grouped[dateKey] = [];
    }
    grouped[dateKey]!.add(log);
  }
  return grouped;
}

@riverpod
List<DateTime> sortedDates(SortedDatesRef ref) {
  final grouped = ref.watch(groupedLogsProvider);
  return grouped.keys.toList()..sort((a, b) => b.compareTo(a));
}

class GrassThresholds {
  final int lv2; // minutes for Lv 2
  final int lv3; // minutes for Lv 3
  final int lv4; // minutes for Lv 4

  const GrassThresholds({
    this.lv2 = 60,
    this.lv3 = 180,
    this.lv4 = 300,
  });

  int getLevel(int netMinutes) {
    if (netMinutes >= lv4) return 4;
    if (netMinutes >= lv3) return 3;
    if (netMinutes >= lv2) return 2;
    return 1; // Includes negative values
  }
}

@riverpod
Map<DateTime, int> grassLevels(GrassLevelsRef ref) {
  final logsAsync = ref.watch(logListRangeProvider);
  final logs = logsAsync.valueOrNull ?? [];
  
  if (logs.isEmpty) return {};

  // 1. Calculate net minutes per day
  final Map<DateTime, int> dailyNetMinutes = {};
  for (var log in logs) {
    final dateKey = DateTime(log.targetDate.year, log.targetDate.month, log.targetDate.day);
    
    int delta = 0;
    if (log.snapshotValue == TimeValue.productive) {
      delta = log.duration;
    } else if (log.snapshotValue == TimeValue.waste) {
      delta = -log.duration;
    }
    
    dailyNetMinutes[dateKey] = (dailyNetMinutes[dateKey] ?? 0) + delta;
  }

  // 2. Map to levels using thresholds (Future-ready structure)
  const thresholds = GrassThresholds();
  final Map<DateTime, int> levels = {};
  
  dailyNetMinutes.forEach((date, netMinutes) {
    levels[date] = thresholds.getLevel(netMinutes);
  });

  return levels;
}
