import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';

enum DeleteCategoryAction {
  cancel,
  keepHistory, // "과거 기록은 남기기"
  deleteAll, // "전부 지우기"
}

class DeleteCategoryDialog extends StatefulWidget {
  final String categoryName;

  const DeleteCategoryDialog({
    super.key,
    required this.categoryName,
  });

  static Future<DeleteCategoryAction?> show(BuildContext context, {required String categoryName}) {
    return showDialog<DeleteCategoryAction>(
      context: context,
      builder: (context) => DeleteCategoryDialog(categoryName: categoryName),
    );
  }

  @override
  State<DeleteCategoryDialog> createState() => _DeleteCategoryDialogState();
}

class _DeleteCategoryDialogState extends State<DeleteCategoryDialog> {
  int _step = 1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColorsLegacy.bgSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _step == 1 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "카테고리 삭제",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColorsLegacy.fgPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "정말 '${widget.categoryName}' 카테고리를\n삭제하시겠습니까?\n이 작업은 취소할 수 없습니다.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColorsLegacy.fgSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context, DeleteCategoryAction.cancel),
                style: TextButton.styleFrom(
                  foregroundColor: AppColorsLegacy.fgSecondary,
                ),
                child: const Text("취소"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _step = 2;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsLegacy.error,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("삭제"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "과거 기록 처리",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColorsLegacy.fgPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "삭제한 '${widget.categoryName}' 카테고리의\n과거 기록도 모두 지우시겠습니까?\n이 작업은 취소할 수 없습니다.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColorsLegacy.fgSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context, DeleteCategoryAction.keepHistory),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColorsLegacy.fgTertiary),
                foregroundColor: AppColorsLegacy.fgPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "과거 기록은 남기기",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, DeleteCategoryAction.deleteAll),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorsLegacy.error,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "전부 지우기",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
