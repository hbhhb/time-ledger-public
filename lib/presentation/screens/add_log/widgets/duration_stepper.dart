import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/icon_utils.dart'; // Using AppIcon for consistency if needed, checking Lucide for plus/minus

class DurationStepper extends StatelessWidget {
  final int durationMinutes;
  final ValueChanged<int> onChanged;

  const DurationStepper({
    super.key,
    required this.durationMinutes,
    required this.onChanged,
  });

  // Steps: 5, 10, 15, 20, 25, 30, 45, 60, 75, 90, 105, 120, 150, 180, 240
  // After 240: +60
  static const List<int> _steps = [
    5, 10, 15, 20, 25, 30, 45, 60, 75, 90, 105, 120, 150, 180, 240
  ];

  void _increment() {
    if (durationMinutes < 240) {
      // Find next step
      for (final step in _steps) {
        if (step > durationMinutes) {
          onChanged(step);
          return;
        }
      }
      // If matches last step or greater, add 60
      if (durationMinutes >= 240) {
        onChanged(durationMinutes + 60);
      }
    } else {
      onChanged(durationMinutes + 60);
    }
  }

  void _decrement() {
    if (durationMinutes <= 5) {
      onChanged(0); // Optional: Allow 0? Or min 5? Assuming min 0 or 5.
      return;
    }
    
    if (durationMinutes > 240) {
      onChanged(durationMinutes - 60);
      return;
    }

    // Find prev step
    for (int i = _steps.length - 1; i >= 0; i--) {
      if (_steps[i] < durationMinutes) {
        onChanged(_steps[i]);
        return;
      }
    }
    // Fallback
    onChanged(0);
  }
  
  String _formatDuration(int minutes) {
    if (minutes == 0) return "0분";
    final h = minutes ~/ 60;
    final m = minutes % 60;
    
    if (h > 0) {
      if (m > 0) return "${h}시간 ${m}분";
      return "${h}시간";
    }
    return "${m}분";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CircleButton(
              icon: Icons.remove, 
              onTap: _decrement,
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 160), // Wider to accommodate "10시간 30분"
              alignment: Alignment.center,
              child: Text(
                _formatDuration(durationMinutes),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48, // Larger font
                  fontWeight: FontWeight.w700,
                  color: AppColorsLegacy.fgPrimary,
                  fontFamily: 'Pretendard', 
                  letterSpacing: -1.0, // Tighter tracking
                  height: 1.0,
                ),
              ),
            ),
            _CircleButton(
              icon: Icons.add,
              onTap: _increment,
              isPrimary: true,
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "시간/분을 터치하여 직접 입력",
          style: TextStyle(
            fontSize: 14,
            color: AppColorsLegacy.fgTertiary,
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPrimary ? AppColorsLegacy.fgPrimary : AppColorsLegacy.bgSecondary,
          ),
          child: Icon(
            icon,
            size: 28,
            color: isPrimary ? AppColorsLegacy.bgPrimary : AppColorsLegacy.fgPrimary,
          ),
        ),
      ),
    );
  }
}
