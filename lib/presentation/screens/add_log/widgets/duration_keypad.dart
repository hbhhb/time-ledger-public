import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';

class DurationKeypad extends StatelessWidget {
  final ValueChanged<int> onDigitTap;
  final VoidCallback onBackspace;
  final VoidCallback onClear;

  const DurationKeypad({
    super.key,
    required this.onDigitTap,
    required this.onBackspace,
    required this.onClear,
  });

  Widget _buildButton(String label, VoidCallback onTap, {Color? textColor, Color? bgColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor ?? AppColorsLegacy.bgSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: textColor ?? AppColorsLegacy.fgPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildButton('1', () => onDigitTap(1)),
                _buildButton('2', () => onDigitTap(2)),
                _buildButton('3', () => onDigitTap(3)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildButton('4', () => onDigitTap(4)),
                _buildButton('5', () => onDigitTap(5)),
                _buildButton('6', () => onDigitTap(6)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildButton('7', () => onDigitTap(7)),
                _buildButton('8', () => onDigitTap(8)),
                _buildButton('9', () => onDigitTap(9)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildButton('C', onClear, textColor: AppColorsLegacy.destructive),
                _buildButton('0', () => onDigitTap(0)),
                _buildButton('←', onBackspace),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
