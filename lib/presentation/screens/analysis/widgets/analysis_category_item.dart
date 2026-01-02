import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/presentation/screens/analysis/providers/analysis_providers.dart'; // For AggregatedCategory

class AnalysisCategoryItem extends StatelessWidget {
  final AggregatedCategory category;

  const AnalysisCategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final bool isProductive = category.type == TimeValue.productive;
    final bool isWaste = category.type == TimeValue.waste;

    // Styling logic reused from LogListItem
    final Color iconBgColor = isProductive ? AppColorsLegacy.bgInverseSecondary : AppColorsLegacy.bgSecondary;
    final Color? iconBorderColor = isWaste ? AppColorsLegacy.fgSlight : null;

    final Duration d = Duration(minutes: category.totalDuration);
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);

    String durationText = "";
    if (hours > 0) durationText += "${hours}시간 ";
    if (minutes > 0) durationText += "${minutes}분";
    durationText = durationText.trim();
    if (durationText.isEmpty) durationText = "0분";

    final Color durationColor = isWaste ? AppColorsLegacy.fgTertiary : AppColorsLegacy.fgPrimary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              border: isWaste ? Border.all(color: AppColorsLegacy.fgSlight, width: 0.5) : null,
            ),
            alignment: Alignment.center,
            child: IconUtils.getIcon(
              category.categoryIcon.isNotEmpty ? category.categoryIcon : "📁",
              size: AppIconSize.md,
              color: isProductive ? AppColorsLegacy.fgInverse : null,
            ),
          ),
          const SizedBox(width: 12),
          
          // Name
          Expanded(
            child: Text(
              category.categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorsLegacy.fgSecondary,
                fontFamily: 'Pretendard',
                letterSpacing: -0.16,
                height: 1.5,
              ),
            ),
          ),

          // Duration
          Text(
            durationText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: durationColor,
              fontFamily: 'Pretendard',
              letterSpacing: -0.16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
