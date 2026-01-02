import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';

class LogListItem extends StatelessWidget {
  final LogEntity log;

  const LogListItem({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    
    final bool isProductive = log.snapshotValue == TimeValue.productive;
    final bool isWaste = log.snapshotValue == TimeValue.waste;

    // Icon Container Styles
    final Color iconBgColor = isProductive ? AppColorsLegacy.bgInverseSecondary : AppColorsLegacy.bgSecondary;
    final Color? iconBorderColor = isWaste ? AppColorsLegacy.fgSlight : null;
    
    // Duration Styles
    final Duration d = Duration(minutes: log.duration);
    final hours = d.inHours; 
    final minutes = d.inMinutes.remainder(60);
    
    String durationText = "";
    if (hours > 0) durationText += "${hours}시간 ";
    if (minutes > 0) durationText += "${minutes}분";
    durationText = durationText.trim();
    
    // Add prefix for waste
    if (isWaste) {
      durationText = "-$durationText";
    }

    final Color durationColor = isWaste ? AppColorsLegacy.fgTertiary : AppColorsLegacy.fgPrimary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8), // Flat list padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon with background
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isProductive ? AppColorsLegacy.bgInverseSecondary : AppColorsLegacy.bgSecondary,
              shape: BoxShape.circle,
              border: isWaste ? Border.all(color: AppColorsLegacy.fgSlight, width: 0.5) : null,
            ),
            alignment: Alignment.center,
            child: IconUtils.getIcon(
              log.categoryId == null 
                  ? log.snapshotIcon // If unlinked (history kept), use snapshot
                  : (log.categoryIcon ?? log.snapshotIcon), // If linked, use category icon (current), fallback to snapshot
              size: AppIconSize.md, 
              color: isProductive ? AppColorsLegacy.fgInverse : null,
            ),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  log.snapshotName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400, // Regular per Figma check (or Medium?) Figma: 16px Regular
                    color: AppColorsLegacy.fgSecondary,
                    fontFamily: 'Pretendard',
                    letterSpacing: -0.16,
                    height: 1.5,
                  ),
                ),
                if (log.memo != null && log.memo!.isNotEmpty) ...[
                  Text(
                    log.memo!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColorsLegacy.fgTertiary,
                      fontFamily: 'Pretendard',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]
              ],
            ),
          ),

          // Duration
          Text(
            durationText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500, // Medium per Figma check
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
