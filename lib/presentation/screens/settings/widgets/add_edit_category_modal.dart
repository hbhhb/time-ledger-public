import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/settings/widgets/delete_category_dialog.dart';
import 'package:time_ledger/presentation/screens/settings/widgets/update_category_dialog.dart';
import 'package:time_ledger/presentation/screens/analysis/providers/analysis_providers.dart'; // Added
import 'package:uuid/uuid.dart';

class AddEditCategoryModal extends ConsumerStatefulWidget {
  final CategoryEntity? category;

  const AddEditCategoryModal({super.key, this.category});

  static Future<void> show(BuildContext context, {CategoryEntity? category}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditCategoryModal(category: category),
    );
  }

  @override
  ConsumerState<AddEditCategoryModal> createState() => _AddEditCategoryModalState();
}

class _AddEditCategoryModalState extends ConsumerState<AddEditCategoryModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  
  TimeValue _timeValue = TimeValue.productive;
  
  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _iconController.text = widget.category!.icon;
      _timeValue = widget.category!.defaultValue;
    } else {
      _iconController.text = "📁";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      decoration: const BoxDecoration(
        color: AppColorsLegacy.bgSecondary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                _isEditing ? '카테고리 정보 수정' : '새 시간 카테고리 추가',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColorsLegacy.fgPrimary,
                  fontFamily: 'Pretendard',
                ),
              ),
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(LucideIcons.x, color: AppColorsLegacy.fgPrimary),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              if (_isEditing)
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(LucideIcons.trash2, color: AppColorsLegacy.error),
                    onPressed: _handleDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Emoji Input
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColorsLegacy.bgPrimary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _iconController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.allow(RegExp(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'
                  )),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),

          // Name Input
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColorsLegacy.fgPrimary,
            ),
            decoration: const InputDecoration(
              hintText: '이름을 입력하세요',
              hintStyle: TextStyle(color: AppColorsLegacy.fgTertiary),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            cursorColor: AppColorsLegacy.brandPrimary,
          ),

          const SizedBox(height: 32),

          // Time Value Toggle
          Row(
            children: [
              Expanded(
                child: _buildValueButton(TimeValue.productive),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildValueButton(TimeValue.waste),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Save Button
          ElevatedButton(
            onPressed: () => _handleSave(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1C1C1E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              "저장",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueButton(TimeValue value) {
    final isSelected = _timeValue == value;
    final label = value == TimeValue.productive ? '생산적' : '소비적';
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _timeValue = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColorsLegacy.fgPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColorsLegacy.borderDefault,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final name = _nameController.text.trim();
    final icon = _iconController.text.characters.firstOrNull ?? "📁";
    
    if (name.isEmpty) return;

    final repo = ref.read(categoryRepositoryProvider);
    final logRepo = ref.read(logRepositoryProvider);

    try {
      if (!_isEditing) {
        final newCategory = CategoryEntity(
          id: const Uuid().v4(),
          name: name,
          icon: icon,
          defaultValue: _timeValue,
        );
        await repo.createCategory(newCategory);
      } else {
        final oldCategory = widget.category!;
        bool nameChanged = oldCategory.name != name;
        bool iconChanged = oldCategory.icon != icon;
        bool valueChanged = oldCategory.defaultValue != _timeValue;

        // Treat Name OR Icon change as an "Identity" change requiring confirmation
        if (nameChanged || iconChanged) {
           final action = await UpdateCategoryDialog.show(
             context, 
             oldName: oldCategory.name,
             newName: name,
             type: UpdateType.name // We reuse 'name' type for general info/identity change
           );

           if (action == null) return;
           if (action == UpdateCategoryAction.futureOnly) {
             // We unlink old logs so they rely on snapshotName/Icon.
             await logRepo.unlinkLogsByCategoryId(oldCategory.id);
           }
        }

        if (valueChanged) {
           final action = await UpdateCategoryDialog.show(
             context, 
             oldName: name, 
             newValue: _timeValue,
             type: UpdateType.property
           );

           if (action == null) return;
           if (action == UpdateCategoryAction.updateAll) {
             // Property changed, update ALL past logs to new value.
             // Note: If unlinked above, this won't find any logs by categoryId, which is correct behavior for "Future Only"
             await logRepo.updateLogSnapshots(oldCategory.id, newValue: _timeValue);
           }
        }

        final updatedCategory = oldCategory.copyWith(
          name: name,
          icon: icon,
          defaultValue: _timeValue,
        );
        await repo.updateCategory(updatedCategory);
      }
      
      if (mounted) Navigator.pop(context);
      ref.invalidate(categoryListProvider);
      ref.invalidate(analysisStatsProvider); // Refreshes analysis tab
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("오류가 발생했습니다: $e")));
    }
  }

  Future<void> _handleDelete() async {
    if (widget.category == null) return;
    final action = await DeleteCategoryDialog.show(context, categoryName: widget.category!.name);
    if (action == null || action == DeleteCategoryAction.cancel) return;

    final repo = ref.read(categoryRepositoryProvider);
    final logRepo = ref.read(logRepositoryProvider);
    final categoryId = widget.category!.id;

    try {
      if (action == DeleteCategoryAction.deleteAll) {
        await logRepo.deleteLogsByCategoryId(categoryId);
      } else {
        // Keep History -> We typically just delete the category.
        // But since we want "Delete" to break link, we should allow Drift to set to NULL (if ON DELETE SET NULL)
        // OR we manually unlink.
        // My LogTable definition has `categoryId` nullable now.
        // However, Drift defaults: `references` usually doesn't set ON DELETE behavior unless specified.
        // Default is NO ACTION (Restrict).
        // If I delete logic, I should unlink first to be safe or rely on Drift.
        await logRepo.unlinkLogsByCategoryId(categoryId);
        // By unlinking, we ensure they become "orphans" with snapshot data.
      }
      
      await repo.deleteCategory(categoryId);
      
      if (mounted) Navigator.pop(context);
      ref.invalidate(categoryListProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("삭제 중 오류가 발생했습니다: $e")));
    }
  }
}
