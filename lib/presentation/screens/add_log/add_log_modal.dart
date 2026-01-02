import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/add_log/widgets/category_selection_step.dart';
import 'package:time_ledger/presentation/screens/add_log/widgets/duration_input_step.dart';
import 'package:time_ledger/presentation/screens/settings/widgets/add_edit_category_modal.dart'; // Import for AddCategory trigger

enum AddLogStep { category, duration }

class AddLogModal extends ConsumerStatefulWidget {
  const AddLogModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColorsLegacy.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddLogModal(),
    );
  }

  @override
  ConsumerState<AddLogModal> createState() => _AddLogModalState();
}

class _AddLogModalState extends ConsumerState<AddLogModal> {
  AddLogStep _currentStep = AddLogStep.category;
  CategoryEntity? _selectedCategory;
  String _memo = ''; // Maintain memo state

  void _onCategorySelected(CategoryEntity category) {
    setState(() {
      _selectedCategory = category;
      _currentStep = AddLogStep.duration;
    });
  }

  void _onBackToCategory() {
    setState(() {
      _currentStep = AddLogStep.category;
      _selectedCategory = null;
    });
  }

  void _onAddCategory() {
    // Open Add Category Modal
    AddEditCategoryModal.show(context);
    // Note: After adding, the list provider auto-updates, so the User can see it immediately on return.
  }

  void _onSave(int durationMinutes) async {
    if (durationMinutes == 0 || _selectedCategory == null) return;

    final targetDate = ref.read(selectedDateProvider) ?? DateTime.now();
    
    try {
      await ref.read(addLogUseCaseProvider).execute(
        targetDate: targetDate,
        categoryId: _selectedCategory!.id,
        duration: durationMinutes,
        memo: _memo.isEmpty ? null : _memo,
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('저장 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate formatted date for title (e.g. 12.13(목) )
    final selectedDate = ref.watch(selectedDateProvider);
    final date = selectedDate ?? DateTime.now();
    final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekDayStr = weekDays[date.weekday - 1];
    final dateStr = "${date.month}.${date.day}($weekDayStr)";
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColorsLegacy.bgPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColorsLegacy.bgSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Title
          Center(
            child: Text(
              "$dateStr의 새 기록",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColorsLegacy.fgSecondary,
                fontFamily: 'Pretendard',
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _currentStep == AddLogStep.category
                  ? CategorySelectionStep(
                      onCategorySelected: _onCategorySelected,
                      onAddCategory: _onAddCategory,
                    )
                  : DurationInputStep(
                      category: _selectedCategory!,
                      onBack: _onBackToCategory,
                      onSave: _onSave,
                      onMemoChanged: (val) => _memo = val,
                    ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
