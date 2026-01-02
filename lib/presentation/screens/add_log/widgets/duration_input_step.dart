import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/presentation/screens/add_log/widgets/duration_stepper.dart';

class DurationInputStep extends StatefulWidget {
  final CategoryEntity category;
  final VoidCallback onBack;
  final ValueChanged<int> onSave; // Returns duration in minutes
  final ValueChanged<String> onMemoChanged;

  const DurationInputStep({
    super.key,
    required this.category,
    required this.onBack,
    required this.onSave,
    required this.onMemoChanged,
  });

  @override
  State<DurationInputStep> createState() => _DurationInputStepState();
}

class _DurationInputStepState extends State<DurationInputStep> {
  int _durationMinutes = 60; // Default 1 hour
  final TextEditingController _memoController = TextEditingController();

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColorsLegacy.bgPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '시간 선택', 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('완료'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(minutes: _durationMinutes),
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      _durationMinutes = newDuration.inMinutes;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _setPreset(int minutes) {
    setState(() {
      _durationMinutes = minutes;
    });
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColorsLegacy.fgPrimary),
                ),
                const Spacer(), // Center the content? Or left align? Design centered.
                Column(
                  children: [
                    IconUtils.getIcon(widget.category.icon, size: AppIconSize.lg),
                    const SizedBox(height: 4),
                    Text(
                      widget.category.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColorsLegacy.fgPrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 48), // Balance the Back button
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Duration Stepper (Tap to open picker)
          GestureDetector(
            onTap: _showTimePicker,
            behavior: HitTestBehavior.opaque,
            child: DurationStepper(
              durationMinutes: _durationMinutes,
              onChanged: (val) => setState(() => _durationMinutes = val),
            ),
          ),

          const SizedBox(height: 40),

          // Presets
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _PresetButton('10분', 10, _setPreset),
                _PresetButton('15분', 15, _setPreset),
                _PresetButton('30분', 30, _setPreset),
                _PresetButton('45분', 45, _setPreset),
                _PresetButton('1시간', 60, _setPreset),
                _PresetButton('2시간', 120, _setPreset),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Memo Input
          TextField(
            controller: _memoController,
            onChanged: widget.onMemoChanged,
            decoration: InputDecoration(
              hintText: '메모를 입력하세요 (선택)',
              filled: true,
              fillColor: AppColorsLegacy.bgSecondary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),
          
          // Save Button (Main)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _durationMinutes > 0 
                  ? () => widget.onSave(_durationMinutes)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorsLegacy.fgPrimary, // Black
                foregroundColor: AppColorsLegacy.fgInverse, // White
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                '저장',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Save & Memo Text Button
          TextButton(
            onPressed: _durationMinutes > 0 
                ? () {
                    // Logic is same as Save (memo is already bound)
                    // Maybe strictly require memo? No, just an alternative trigger.
                    widget.onSave(_durationMinutes);
                  }
                : null,
            child: const Text(
              "저장하고 메모 남기기",
              style: TextStyle(
                color: AppColorsLegacy.fgTertiary,
                fontSize: 14,
                fontFamily: 'Pretendard',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final int minutes;
  final Function(int) onTap;

  const _PresetButton(this.label, this.minutes, this.onTap);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onTap(minutes),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsLegacy.fgPrimary,
        side: const BorderSide(color: AppColorsLegacy.bgSecondary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Pretendard',
          fontSize: 14,
        ),
      ),
    );
  }
}
