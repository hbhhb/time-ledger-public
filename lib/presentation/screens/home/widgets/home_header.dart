import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final displayDate = selectedDate ?? DateTime.now();
    
    // Calculate week number (Simple approximation for now, or use a package)
    // For now, let's just display Month and "Week" based on day/7.
    final weekNum = (displayDate.day / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${displayDate.month}월 ${weekNum}주",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColorsLegacy.fgPrimary,
                  fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                LucideIcons.chevronDown, 
                size: 20, 
                color: AppColorsLegacy.fgPrimary
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Navigate to Settings or Category Management
              Navigator.pushNamed(context, '/settings'); 
            },
            icon: const Icon(LucideIcons.settings, color: AppColorsLegacy.fgPrimary),
          ),
        ],
      ),
    );
  }
}
