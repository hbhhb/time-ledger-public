import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/settings/category_management_screen.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  // Mock state for now
  bool _isReminderEnabled = false;

  @override
  Widget build(BuildContext context) {
    // We might need to fetch category count for the label
    final categoriesAsync = ref.watch(categoryListProvider);
    final categoryCount = categoriesAsync.valueOrNull?.length ?? 0;

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
          '메뉴',
          style: TextStyle(
            color: AppColorsLegacy.fgPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSwitchItem(
              title: "기록 리마인드 알림",
              value: _isReminderEnabled,
              onChanged: (val) {
                setState(() {
                  _isReminderEnabled = val;
                });
              },
            ),
            if (_isReminderEnabled)
              _buildNavigationItem(
                title: "알림 시간",
                value: "오후 10:00",
                onTap: () {
                  // TODO: Show time picker
                },
              ),
            _buildNavigationItem(
              title: "시간 카테고리 관리",
              value: "카테고리 $categoryCount개",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CategoryManagementScreen()),
                );
              },
            ),
            _buildNavigationItem(
              title: "의견 보내기",
              isExternalLink: true,
              onTap: () async {
                final url = Uri.parse('https://tally.so/r/Ek5Vzr');
                try {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } catch (e) {
                  debugPrint('Could not launch \$url: \$e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500, // Medium as per Figma
              color: AppColorsLegacy.fgSecondary, // #313236
              fontFamily: 'Pretendard',
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColorsLegacy.fgPrimary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColorsLegacy.fgSlight, // Using slightly darker grey for visibility
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent), // Removing outline for cleaner look
            trackOutlineWidth: MaterialStateProperty.all(0), // Prevent handle from shrinking
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required String title,
    String? value,
    bool isExternalLink = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorsLegacy.fgPrimary,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColorsLegacy.fgTertiary,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
            Icon(
              isExternalLink ? LucideIcons.arrowUpRight : LucideIcons.chevronRight,
              size: 20,
              color: AppColorsLegacy.fgTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
