import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/core/theme/foundations/app_typography.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';

class MonthNavigationButton extends ConsumerWidget {
  const MonthNavigationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    if (selectedDate == null) return const SizedBox.shrink();

    final previousMonth = DateTime(selectedDate.year, selectedDate.month - 1);
    
    // Format Text
    // Logic: If previous month is in same year -> "MM월 기록 보기"
    // If different year -> "YYYY년 MM월 기록 보기"
    final now = DateTime.now();
    final bool isSameYear = previousMonth.year == now.year;
    
    final String label = isSameYear 
        ? "${previousMonth.month}월 기록 보기" 
        : "${previousMonth.year}년 ${previousMonth.month}월 기록 보기";

    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTypography = Theme.of(context).extension<AppTypography>()!;

    return InkWell(
      onTap: () {
        // Navigate to the last day of the previous month
        final lastDayOfPrevMonth = DateTime(previousMonth.year, previousMonth.month + 1, 0);
        ref.read(selectedDateProvider.notifier).updateDate(lastDayOfPrevMonth);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        child: Text(
          label,
          style: appTypography.body1.medium.copyWith(
             color: appColors.labelAlternative,
          ),
        ),
      ),
    );
  }
}
