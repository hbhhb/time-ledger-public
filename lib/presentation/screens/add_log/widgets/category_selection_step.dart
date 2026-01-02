import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/add_log/widgets/category_selector.dart'; // Reuse provider

class CategorySelectionStep extends ConsumerWidget {
  final ValueChanged<CategoryEntity> onCategorySelected;
  final VoidCallback onAddCategory;

  const CategorySelectionStep({
    super.key,
    required this.onCategorySelected,
    required this.onAddCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return categoriesAsync.when(
      data: (categories) {
        final productiveCategories = categories
            .where((c) => c.defaultValue == TimeValue.productive)
            .toList();
        final wasteCategories = categories
            .where((c) => c.defaultValue == TimeValue.waste)
            .toList();

        if (categories.isEmpty) {
          return Center(
            child: TextButton(
              onPressed: onAddCategory,
              child: const Text("+ 첫 번째 카테고리를 추가해보세요"),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80), // Space for footer
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (productiveCategories.isNotEmpty) ...[
                _buildSectionHeader("생산적 시간"),
                _buildGrid(productiveCategories),
                const SizedBox(height: 24),
              ],
              if (wasteCategories.isNotEmpty) ...[
                _buildSectionHeader("소모적 시간"),
                _buildGrid(wasteCategories),
              ],
              
              // Add Category Button inline or footer? 
              // Design had a footer "+ 새 항목 추가".
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: onAddCategory,
                  icon: const Icon(Icons.add, color: AppColorsLegacy.fgTertiary, size: 20),
                  label: const Text(
                    "새 항목 추가",
                    style: TextStyle(
                      color: AppColorsLegacy.fgTertiary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    backgroundColor: AppColorsLegacy.bgSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColorsLegacy.fgPrimary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColorsLegacy.fgSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<CategoryEntity> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8), // Minimal padding as parent has it?
      // Actually parent has padding? No, parent is SingleScrollView -> Column.
      // We should check parent padding.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24, // More vertical space for text
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60, // Consistent with CategorySelector (64 might be too big for 4 col on small screens)
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColorsLegacy.bgSecondary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: IconUtils.getIcon(
                  category.icon, 
                  size: AppIconSize.xl,
                  color: AppColorsLegacy.fgPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColorsLegacy.fgSecondary,
                  fontFamily: 'Pretendard',
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
