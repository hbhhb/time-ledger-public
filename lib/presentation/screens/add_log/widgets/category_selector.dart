import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart'; // Import TimeValue
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';

class CategorySelector extends ConsumerWidget {
  final String? selectedCategoryId;
  final ValueChanged<CategoryEntity> onSelect;

  const CategorySelector({
    super.key,
    required this.selectedCategoryId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
            return const Center(child: Text("카테고리가 없습니다."));
        }

        final productive = categories.where((c) => c.defaultValue == TimeValue.productive).toList();
        final waste = categories.where((c) => c.defaultValue == TimeValue.waste).toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (productive.isNotEmpty) ...[
                _buildSectionHeader("생산적 시간", true),
                const SizedBox(height: 12),
                _buildGrid(productive),
                const SizedBox(height: 24),
              ],
              if (waste.isNotEmpty) ...[
                _buildSectionHeader("소모적 시간", false),
                const SizedBox(height: 12),
                _buildGrid(waste),
                const SizedBox(height: 24),
              ],
              // Add New Category Button
              TextButton.icon(
                onPressed: () {
                  // This callback handles opening the AddCategoryModal
                  // Passed down from parent
                },
                icon: const Icon(LucideIcons.plus, size: 20, color: AppColorsLegacy.fgTertiary),
                label: const Text(
                  "새 항목 추가",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColorsLegacy.fgTertiary,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pretendard',
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }

  Widget _buildSectionHeader(String title, bool isProductive) {
    return Row(
      children: [
        Icon(
          Icons.circle, 
          size: 8, 
          color: isProductive ? AppColorsLegacy.fgPrimary : AppColorsLegacy.bgSecondary // Productive: Black, Waste: Grey (hollow circle in design? using solid for now or icon)
        ), 
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorsLegacy.fgSecondary,
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<CategoryEntity> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5, // Wide rectangle
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = category.id == selectedCategoryId;

        return GestureDetector(
          onTap: () => onSelect(category),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? AppColorsLegacy.fgPrimary : AppColorsLegacy.bgPrimary,
              border: Border.all(
                color: isSelected ? AppColorsLegacy.fgPrimary : AppColorsLegacy.fgSlight,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Icon
                IconUtils.getIcon(
                  category.icon,
                  size: AppIconSize.md,
                  color: isSelected ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgPrimary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgPrimary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


