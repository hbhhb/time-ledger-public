import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';

class DatePicker extends ConsumerWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final now = DateTime.now();
    
    // Generate dates. For prototype, showing a fixed range customized around the selected date or today.
    // Let's scroll to the selected date ideally. 
    // For now, generating a range of +/- 14 days from today.
    final dates = List.generate(30, (index) {
      return now.subtract(const Duration(days: 15)).add(Duration(days: index));
    });

    // Auto-scroll logic would be nice here, but skipping for MVP step 1.

    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppColorsLegacy.bgPrimary,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          // Formatting
          // Weekday: "Mon" -> "월"
          final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
          final weekDayStr = weekDays[date.weekday - 1];

          return GestureDetector(
            onTap: () {
              ref.read(selectedDateProvider.notifier).state = date;
            },
            child: Container(
              width: 52,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColorsLegacy.fgPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(28), // Pill shape
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    weekDayStr,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgTertiary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgSecondary,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
