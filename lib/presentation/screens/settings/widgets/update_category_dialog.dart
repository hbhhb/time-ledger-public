import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';

enum UpdateCategoryAction {
  futureOnly, // "이후 기록부터 적용" (Unlink or New Category)
  updateAll, // "과거 기록도 모두 변경" (Update Entity)
}

enum UpdateType {
  property, // Value change (Productive <-> Waste)
  name,     // Name change
}

class UpdateCategoryDialog extends StatelessWidget {
  final String oldName;
  final String? newName;
  final TimeValue? newValue;
  final UpdateType type;

  const UpdateCategoryDialog({
    super.key,
    required this.oldName,
    this.newName,
    this.newValue,
    required this.type,
  });

  static Future<UpdateCategoryAction?> show(BuildContext context, {
    required String oldName,
    String? newName,
    TimeValue? newValue,
    required UpdateType type,
  }) {
    return showDialog<UpdateCategoryAction>(
      context: context,
      builder: (context) => UpdateCategoryDialog(
        oldName: oldName,
        newName: newName,
        newValue: newValue,
        type: type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    InlineSpan contentText;

    if (type == UpdateType.property) {
      title = "속성 변경";
      final valueText = newValue == TimeValue.productive ? '생산적 시간' : '소비적 시간';
      contentText = TextSpan(
        text: "'$oldName'의 과거 모든 기록도\n",
        style: const TextStyle(color: AppColorsLegacy.fgSecondary, fontSize: 16, height: 1.5),
        children: [
          TextSpan(
            text: valueText,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColorsLegacy.fgPrimary), // Changed to fgPrimary or specific color
          ),
          const TextSpan(text: "으로 변경하시겠습니까?"),
        ],
      );
    } else {
      title = "이름 변경";
      contentText = TextSpan(
        text: "'$oldName'의 이름을\n",
        style: const TextStyle(color: AppColorsLegacy.fgSecondary, fontSize: 16, height: 1.5),
        children: [
          TextSpan(
            text: "'$newName'",
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColorsLegacy.fgPrimary),
          ),
          const TextSpan(text: "(으)로 변경하시겠습니까?"),
        ],
      );
    }

    return Dialog(
      backgroundColor: AppColorsLegacy.bgSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColorsLegacy.fgPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text.rich(
              contentText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, UpdateCategoryAction.futureOnly),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColorsLegacy.fgTertiary), // Grey border
                    foregroundColor: AppColorsLegacy.fgPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "이후 기록부터 적용",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, UpdateCategoryAction.updateAll),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C1C1E), // Dark button
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "과거 기록도 모두 변경",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
