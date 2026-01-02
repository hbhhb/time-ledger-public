import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/screens/settings/menu_screen.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    // Simple week calculation
    final weekNum = (selectedDate.day / 7).ceil();

    return AppBar(
      backgroundColor: Colors.transparent, // Figma: bg-primary (white)
      elevation: 0,
      centerTitle: false,
      titleSpacing: 24, // Matches Figma padding
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${selectedDate.month}월 ${weekNum}주",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColorsLegacy.fgPrimary,
              fontFamily: 'Pretendard',
              letterSpacing: -0.18,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(LucideIcons.chevronDown, size: 18, color: AppColorsLegacy.fgTertiary),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MenuScreen()),
              );
            },
            icon: const AppIcon(LucideIcons.menu),
            color: AppColorsLegacy.fgPrimary,
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
