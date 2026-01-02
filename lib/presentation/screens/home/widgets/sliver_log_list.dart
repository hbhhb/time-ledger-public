import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/home/widgets/log_list_item.dart';
import 'package:time_ledger/presentation/screens/home/widgets/month_navigation_button.dart';

// Local provider removed, moved to home_providers.dart

class SliverLogList extends ConsumerStatefulWidget {
  const SliverLogList({super.key});

  @override
  ConsumerState<SliverLogList> createState() => _SliverLogListState();
}

class _SliverLogListState extends ConsumerState<SliverLogList> {
  // Constants for synchronization calculation in HomeScreen
  static const double dayHeaderHeight = 32.0;
  static const double headerGapHeight = 8.0;
  static const double logItemHeight = 56.0;
  static const double dayGapHeight = 24.0;
  static const double topPadding = 12.0;
  static const double sidePadding = 24.0;

  @override
  Widget build(BuildContext context) {
    final sortedDates = ref.watch(sortedDatesProvider);
    final groupedLogs = ref.watch(groupedLogsProvider);

    if (sortedDates.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text(
            "기록이 없습니다.",
            style: TextStyle(
              fontSize: 14,
              color: AppColorsLegacy.fgTertiary,
              fontFamily: 'Pretendard',
            ),
          ),
        ),
      );
    }

    final hasPreviousLogs = ref.watch(hasLogsInPreviousMonthProvider);

    return SliverPadding(
      padding: const EdgeInsets.only(left: sidePadding, right: sidePadding, top: topPadding, bottom: 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // Footer (Month Navigation Button)
            if (index == sortedDates.length) {
              if (hasPreviousLogs) {
                return const MonthNavigationButton();
              } else {
                return const SizedBox.shrink();
              }
            }

            final date = sortedDates[index];
            final dayLogs = groupedLogs[date] ?? [];

            // Calculate Totals
            int prodMin = 0;
            int wasteMin = 0;
            for (var log in dayLogs) {
              if (log.snapshotValue == TimeValue.productive) prodMin += log.duration;
              if (log.snapshotValue == TimeValue.waste) wasteMin += log.duration;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: dayHeaderHeight,
                  child: _DateHeader(
                    date: date,
                    totalProductiveMinutes: prodMin,
                    totalWasteMinutes: wasteMin,
                  ),
                ),
                const SizedBox(height: headerGapHeight),
                ...dayLogs.map((log) => SizedBox(
                  height: logItemHeight,
                  child: LogListItem(log: log),
                )),
                const SizedBox(height: dayGapHeight),
              ],
            );
          },
          childCount: sortedDates.length + 1, // +1 for Footer
        ),
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime date;
  final int totalProductiveMinutes;
  final int totalWasteMinutes;

  const _DateHeader({
    required this.date,
    required this.totalProductiveMinutes,
    required this.totalWasteMinutes,
  });

  String _formatDuration(int minutes, {bool isNegative = false}) {
    if (minutes == 0) return "-";
    final d = Duration(minutes: minutes);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    String text = "";
    if (h > 0) text += "${h}시간 ";
    if (m > 0) text += "${m}분";
    text = text.trim();
    return isNegative ? "-$text" : text;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    
    if (target == today) {
      return "${date.day}일 오늘";
    }
    final weekdayNames = ["월", "화", "수", "목", "금", "토", "일"];
    return "${date.day}일 ${weekdayNames[date.weekday - 1]}요일";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _formatDate(date),
              style: const TextStyle(
                fontSize: 14,
                color: AppColorsLegacy.fgTertiary,
                fontFamily: 'Pretendard',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1,
                color: AppColorsLegacy.fgSlight,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _formatDuration(totalProductiveMinutes),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColorsLegacy.fgPrimary, 
                fontFamily: 'Pretendard',
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _formatDuration(totalWasteMinutes, isNegative: true),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorsLegacy.fgTertiary,
                fontFamily: 'Pretendard',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
