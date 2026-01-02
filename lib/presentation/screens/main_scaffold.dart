import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:time_ledger/presentation/screens/add_log/add_log_modal.dart';
import 'package:time_ledger/presentation/screens/home/home_screen.dart';
import 'package:time_ledger/presentation/screens/analysis/analysis_screen.dart';
import 'package:time_ledger/core/utils/icon_utils.dart';
import 'package:time_ledger/presentation/common/app_interactive.dart';


import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/core/theme/foundations/app_typography.dart';

class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AnalysisScreen(), // Analysis Tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTypography = Theme.of(context).extension<AppTypography>()!;

    return Scaffold(
      backgroundColor: appColors.backgroundNormalNormal,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: appColors.backgroundNormalNormal,
          border: Border(
            top: BorderSide(color: appColors.lineNormalAlternative, width: 1.0),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Home Tab
                  Expanded(
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.55,
                        heightFactor: 1.0,
                        child: AppInteractive.builder(
                          onTap: () => _onItemTapped(0),
                          style: AppInteractionStyle.light,
                          hapticEnabled: true,
                          builder: (context, state) {
                            final isSelected = _selectedIndex == 0;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // Overlay Layer (Fills the 55% box)
                                Positioned.fill(
                                  child: AppInteractiveOverlay(
                                    style: AppInteractionStyle.light,
                                    state: state,
                                    borderRadius: BorderRadius.circular(11.4),
                                  ),
                                ),
                                // Content Layer
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(
                                      LucideIcons.bookOpen,
                                      size: AppIconSize.xl,
                                      color: isSelected ? appColors.labelNormal : appColors.labelAlternative,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '가계부',
                                      style: appTypography.caption1.medium.copyWith(
                                        color: isSelected ? appColors.labelNormal : appColors.labelAlternative,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  // Center Add Button (Pill Shaped)
                  AppInteractive.builder(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const AddLogModal(),
                      );
                    },
                    hapticEnabled: true,
                    style: AppInteractionStyle.light,
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100, // Wide Pill Shape
                            height: 52,
                            decoration: BoxDecoration(
                              color: appColors.primaryNormal,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(LucideIcons.plus, color: appColors.inverseLabel, size: 28),
                            ),
                          ),
                          // Overlay covering the whole pill
                          Positioned.fill(
                            child: AppInteractiveOverlay(
                              style: AppInteractionStyle.light,
                              state: state,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Analysis Tab
                  Expanded(
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.55,
                        heightFactor: 1.0,
                        child: AppInteractive.builder(
                          onTap: () => _onItemTapped(1),
                          style: AppInteractionStyle.light,
                          hapticEnabled: true,
                          builder: (context, state) {
                            final isSelected = _selectedIndex == 1;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // Overlay Layer (Fills the 55% box)
                                Positioned.fill(
                                  child: AppInteractiveOverlay(
                                    style: AppInteractionStyle.light,
                                    state: state,
                                    borderRadius: BorderRadius.circular(11.4),
                                  ),
                                ),
                                // Content Layer
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(
                                      LucideIcons.pieChart,
                                      size: AppIconSize.xl,
                                      color: isSelected ? appColors.labelNormal : appColors.labelAlternative,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '분석',
                                      style: appTypography.caption1.medium.copyWith(
                                        color: isSelected ? appColors.labelNormal : appColors.labelAlternative,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
