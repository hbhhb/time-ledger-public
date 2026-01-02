import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/screens/analysis/providers/analysis_providers.dart';

class AnalysisSummary extends ConsumerWidget {
  const AnalysisSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(analysisStatsProvider);

    return statsAsync.when(
      data: (stats) {
        final int prod = stats.totalProductiveMinutes;
        final int waste = stats.totalWasteMinutes;
        final int total = prod + waste;
        
        final double prodRatio = total == 0 ? 0 : prod / total;
        
        // Formatter for duration
        String formatDuration(int minutes) {
            final d = Duration(minutes: minutes);
            final h = d.inHours;
            final m = d.inMinutes.remainder(60);
            return "${h}시간 ${m}분";
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Productive
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "생산적 시간",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColorsLegacy.fgTertiary,
                          fontFamily: 'Pretendard',
                          height: 1.5,
                        ),
                      ),
                      Text(
                        formatDuration(prod),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColorsLegacy.fgPrimary,
                          fontFamily: 'Pretendard',
                          letterSpacing: -0.24,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  
                  // Waste
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "소모적 시간",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColorsLegacy.fgTertiary,
                          fontFamily: 'Pretendard',
                          height: 1.5,
                        ),
                      ),
                      Text(
                        formatDuration(waste),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColorsLegacy.fgTertiary, // Gray color for waste per design
                          fontFamily: 'Pretendard',
                          letterSpacing: -0.24,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),

              // Ratio Bar
              Stack(
                children: [
                  // Waste Background (Full Width)
                  Container(
                    height: 24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColorsLegacy.fgSlight,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  // Productive Foreground (Percentage Width)
                  if (prodRatio > 0)
                    FractionallySizedBox(
                      widthFactor: prodRatio,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColorsLegacy.fgPrimary,
                          borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(100),
                            right: prodRatio >= 0.99 ? const Radius.circular(100) : Radius.zero,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
