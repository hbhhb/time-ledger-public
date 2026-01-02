import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/settings/widgets/add_edit_category_modal.dart';

class CategoryManagementScreen extends ConsumerWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return Scaffold(
      backgroundColor: AppColorsLegacy.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColorsLegacy.bgPrimary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppColorsLegacy.fgPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '시간 카테고리 관리',
          style: TextStyle(
            color: AppColorsLegacy.fgPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
      body: Stack(
        children: [
          categoriesAsync.when(
            data: (categories) {
              if (categories.isEmpty) {
                return const Center(child: Text("등록된 카테고리가 없습니다."));
              }

              final productiveCategories = categories
                  .where((c) => c.defaultValue == TimeValue.productive)
                  .toList();
              final wasteCategories = categories
                  .where((c) => c.defaultValue == TimeValue.waste)
                  .toList();

              return ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                children: [
                  _buildSectionHeader("생산적 시간"),
                  ...productiveCategories.map((c) => _buildCategoryItem(context, c)),
                  const SizedBox(height: 24),
                  _buildSectionHeader("소비적 시간"), // Mapped from 'waste'
                  ...wasteCategories.map((c) => _buildCategoryItem(context, c)),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: _buildAddButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColorsLegacy.fgPrimary, // or specific color
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColorsLegacy.fgPrimary,
              fontFamily: 'Pretendard',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryEntity category) {
    return InkWell(
      onTap: () {
        AddEditCategoryModal.show(context, category: category);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Icon Placeholder
            Container(
              width: 24, // Smaller than before (40 -> 24?) Design looks small
              height: 24,
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   color: AppColorsLegacy.bgSecondary,
              //   borderRadius: BorderRadius.circular(4),
              // ),
              // Design shows just the icon, maybe small background?
              // Screenshot shows black icon on white/transparent?
              // Let's assume just icon for now or small container matching LogListView
               child: IconUtils.getIcon(category.icon, size: AppIconSize.sm, color: AppColorsLegacy.fgPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 16, // Looks like 16
                  color: AppColorsLegacy.fgPrimary,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 20, color: AppColorsLegacy.fgTertiary),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AddEditCategoryModal.show(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E), // Dark color from design
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.plus, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "새 카테고리 추가",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Pretendard',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
