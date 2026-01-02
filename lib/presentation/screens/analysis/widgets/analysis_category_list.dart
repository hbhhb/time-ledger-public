import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/screens/analysis/providers/analysis_providers.dart';
import 'package:time_ledger/presentation/screens/analysis/widgets/analysis_category_item.dart';

class AnalysisCategoryList extends ConsumerWidget {
  const AnalysisCategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(analysisStatsProvider);

    return statsAsync.when(
      data: (stats) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Productive List
              if (stats.productiveCategories.isNotEmpty) ...[
                _buildSectionHeader("생산적 시간", stats.totalProductiveMinutes, isWaste: false),
                const SizedBox(height: 8),
                ...stats.productiveCategories.map((cat) => AnalysisCategoryItem(category: cat)),
              ],

              const SizedBox(height: 32),

              // Waste List
              if (stats.wasteCategories.isNotEmpty) ...[
                _buildSectionHeader("소모적 시간", stats.totalWasteMinutes, isWaste: true),
                const SizedBox(height: 8),
                ...stats.wasteCategories.map((cat) => AnalysisCategoryItem(category: cat)),
              ],
              
              const SizedBox(height: 48), // Bottom padding
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const Text("Failed to load list"),
    );
  }

  Widget _buildSectionHeader(String title, int totalMinutes, {required bool isWaste}) {
    final d = Duration(minutes: totalMinutes);
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    
    String durationText = "";
    if (hours > 0) durationText += "${hours}시간 ";
    if (minutes > 0) durationText += "${minutes}분";
    durationText = durationText.trim();
    if (durationText.isEmpty) durationText = "0분";
    
    // Add minus sign for waste
    if (isWaste) durationText = "-$durationText";

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorsLegacy.fgTertiary,
            fontFamily: 'Pretendard',
            height: 1.5,
          ),
        ),
        const SizedBox(width: 12),
        // Divider line
        Expanded(
          child: Container(
            height: 1, // Thin line
            color: AppColorsLegacy.fgSlight,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          durationText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isWaste ? AppColorsLegacy.fgTertiary : AppColorsLegacy.fgPrimary,
            fontFamily: 'Pretendard',
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
