import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/screens/analysis/providers/analysis_providers.dart';
import 'package:time_ledger/presentation/screens/settings/menu_screen.dart';

class AnalysisHeader extends ConsumerWidget {
  const AnalysisHeader({super.key});

  String _formatDateRange(DateTime date) {
    // Logic to calculate week range
    // Assuming week starts on Monday? Figma says "12.02 - 12.08" for "12월 2주".
    // Need to correctly identify the week of the month.
    
    final int currentWeekday = date.weekday; // 1(Mon) to 7(Sun)
    final DateTime startOfWeek = date.subtract(Duration(days: currentWeekday - 1));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    // Format: "MM.dd - MM.dd"
    final startStr = DateFormat('MM.dd').format(startOfWeek);
    final endStr = DateFormat('MM.dd').format(endOfWeek);
    
    return "$startStr - $endStr";
  }

  String _formatWeekTitle(DateTime date) {
    // "12월 2주"
    // Calculate week number of month
    // Simple algorithm: Week of month = (day + startDayOfMonth.weekday - 2) / 7 + 1
    // Let's use a simpler approach or a utility if available.
    // For now: 
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    // Determine week index
    // This is tricky because "1st week" definition varies.
    // Let's approximate: 
    // Week 1 represents the week containing the 1st day? Or full weeks?
    // Common KR standard: Week containing Thursday is the week?
    // Let's reuse logic if exists, otherwise simple math.
    
    int weekOfMonth = ((date.day + (firstDayOfMonth.weekday - 1)) / 7).ceil();
    // Adjust if first day is part of prev month's week?
    // Let's try: int weekOfMonth = ((date.day - 1) / 7).floor() + 1; // Very naive
    
    // Better: 
    // If we want "Nth week", we can just assume standard calendar rows.
    // Let's calculate week number based on Monday start.
    int day = date.day;
    int firstMondaysOffset = (8 - firstDayOfMonth.weekday) % 7; 
    // This is getting complicated. Let's stick to a simple one:
    // "12월 X주" -> Just using standard week calculation.
    
    // Let's count how many Mondays have passed in this month up to this date.
    // If date is before first Monday, it might be 1st week?
    
    // To match Figma "12.02 - 12.08" is "12월 2주". 
    // 2023-12-02 is Saturday. 
    // 2024-12-02 is Monday.
    // If 12.02 is Monday, and it's "2nd week", that implies 1st week was Nov/Dec cross?
    // Actually "12월 2주" usually means the 2nd week that falls in Dec.
    
    // Let's implement a standard `weekOfMonth` and `month` from the `startOfWeek`.
    final int currentWeekday = date.weekday; 
    final DateTime startOfWeek = date.subtract(Duration(days: currentWeekday - 1));
    
    // Use startOfWeek's month for the label
    final int month = startOfWeek.month;
    
    // Calculate week number in that month
    // Iterate from 1st of month, adding 7 days until we pass startOfWeek
    DateTime temp = DateTime(startOfWeek.year, startOfWeek.month, 1);
    int weekCount = 1;
    // Align temp to Monday? No, just weeks.
    // Let's assume week 1 is the first week containing any days of the month?
    // Or full week?
    // Let's stick to: "Ceiling(Day / 7)" is too simple.
    // How about generic week number of month:
    int weekNumber = ((startOfWeek.day - 1) / 7).floor() + 1;
    
    return "${month}월 ${weekNumber}주";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = ref.watch(analysisDateProvider);
    final isNextButtonEnabled = _canGoNext(currentDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          // Title Row (Menu icon optional? Figma shows hamburger on right, "분석" on left)
          // But main implementation has title in navigation.
          // Figma "분석" is on top left large.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "분석",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColorsLegacy.fgPrimary,
                    fontFamily: 'Pretendard',
                    letterSpacing: -0.24, // Keep letter spacing or adjust? Usually -0.02em = -0.36 for 18. Let's keep existing relative or just set standard. User didn't specify spacing, but usually smaller font needs different spacing. Let's leave it or set to match -0.18 roughly? But user only said 18/w600/150%. I will leave spacing as is or -0.2 is fine.
                    height: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MenuScreen()),
                    );
                  },
                  child: const Icon(LucideIcons.menu, color: AppColorsLegacy.fgPrimary, size: 24),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),

          // Date Navigator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => ref.read(analysisDateProvider.notifier).previousWeek(),
                icon: const Icon(LucideIcons.chevronLeft, color: AppColorsLegacy.fgTertiary),
              ),
              Column(
                children: [
                  Text(
                    _formatWeekTitle(currentDate),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColorsLegacy.fgPrimary,
                      fontFamily: 'Pretendard',
                      height: 1.5,
                    ),
                  ),
                  Text(
                    _formatDateRange(currentDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColorsLegacy.fgTertiary,
                      fontFamily: 'Pretendard',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: isNextButtonEnabled 
                  ? () => ref.read(analysisDateProvider.notifier).nextWeek() 
                  : null,
                icon: Icon(
                  LucideIcons.chevronRight, 
                  color: isNextButtonEnabled ? AppColorsLegacy.fgTertiary : AppColorsLegacy.fgSlight
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _canGoNext(DateTime currentDate) {
    // "다만, 다음 주가 이미 도래한 날이 하나도 없다면"
    // Check if next week's start date is in the future relative to today (now).
    final now = DateTime.now();
    final currentWeekday = currentDate.weekday;
    final startOfCurrentWeek = currentDate.subtract(Duration(days: currentWeekday - 1));
    final startOfNextWeek = startOfCurrentWeek.add(const Duration(days: 7));
    
    // Normalize to date only
    final today = DateTime(now.year, now.month, now.day);
    final nextWeekStart = DateTime(startOfNextWeek.year, startOfNextWeek.month, startOfNextWeek.day);
    
    return !nextWeekStart.isAfter(today);
  }
}
