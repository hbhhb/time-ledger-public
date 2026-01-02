import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/core/theme/foundations/app_typography.dart';
import 'package:time_ledger/presentation/common/app_interactive.dart';

enum CalendarItemState {
  normal,   // Default: Interactive (Hover/Press), Grass visible
  selected, // Selected: Non-interactive, Bold text, Grass visible
  inactive, // Future: Non-interactive, Dimmed text, Grass invisible
  empty,    // Gap: Invisible/None
}

class CalendarItemNew extends StatelessWidget {
  final String dateText;
  final CalendarItemState state;
  final int grassLevel; // 0 ~ 4
  final bool isToday;
  final VoidCallback? onTap;

  const CalendarItemNew({
    super.key,
    required this.dateText,
    this.state = CalendarItemState.normal,
    this.grassLevel = 0,
    this.isToday = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (state == CalendarItemState.empty) {
      return const SizedBox.shrink();
    }

    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTypography = Theme.of(context).extension<AppTypography>()!;

    // 1. Determine Text Style & Color
    TextStyle textStyle;
    Color textColor;
    
    switch (state) {
      case CalendarItemState.selected:
        textStyle = appTypography.body1.bold; // SemiBold 16px
        textColor = appColors.labelStrong;
        break;
      case CalendarItemState.inactive:
        textStyle = appTypography.body1.regular;
        textColor = appColors.labelAssistive;
        break;
      case CalendarItemState.normal:
      default:
        textStyle = appTypography.body1.regular;
        textColor = appColors.labelNeutral;
        break;
    }

    // 2. Determine Grass Color
    Color grassColor;
    if (state == CalendarItemState.inactive || grassLevel == 0) {
      grassColor = Colors.transparent;
    } else {
      switch (grassLevel) {
        case 4: grassColor = appColors.grassLv4; break;
        case 3: grassColor = appColors.grassLv3; break;
        case 2: grassColor = appColors.grassLv2; break;
        case 1: grassColor = appColors.grassLv1; break;
        default: grassColor = appColors.grassLv1; break;
      }
    }

    // 3. Build Content (Text + Grass)
    Widget content = Padding(
      padding: const EdgeInsets.only(top: 7), // Visual center for Text+Grass (approx 32px) in 50px height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Stack from top
        children: [
          Text(
            dateText,
            style: textStyle.copyWith(color: textColor, height: 1.5),
          ),
          const SizedBox(height: 2), // Figma gap: 2px
          Container(
            width: 14,
            height: 6,
            decoration: BoxDecoration(
              color: grassColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );

    // 4. Refactored Structure with Separated Selection Box
    final isSelected = state == CalendarItemState.selected;
    final isNormal = state == CalendarItemState.normal;
    final appShadows = Theme.of(context).extension<AppShadows>()!;

    return AppInteractive.builder(
      onTap: isNormal ? onTap : null,
      hapticEnabled: true,
      style: AppInteractionStyle.light,
      builder: (context, interactionState) {
        return Container(
          width: 49,
          height: 50,
          color: Colors.transparent, // Ensure clickability
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Selection Box (Animated Background)
              // Width: 81% (approx 40), Height: 96% (approx 48)
              // Figma: inset-[1px_4.5px] -> Top/Bottom 1px, Left/Right 4.5px
              // Using Fixed Insets ensures precise centering relative to 49x50 parent
              Positioned(
                top: 1,
                bottom: 1,
                left: 4.5,
                right: 4.5,
                child: IgnorePointer(
                  child: AnimatedScale(
                    scale: isSelected ? 1.0 : 0.8,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColors.inversePrimary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: isSelected ? appShadows.spreadStrong : [],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 1-1. Today Indicator (Dynamic Size)
              if (isToday)
                Positioned(
                  top: 7,
                  child: Container(
                    padding: EdgeInsets.zero, // Tighter fit
                    constraints: const BoxConstraints(minWidth: 26, minHeight: 22),
                    decoration: BoxDecoration(
                      color: appColors.labelNormal.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      dateText, 
                      style: appTypography.body1.bold.copyWith(color: Colors.transparent), // Hidden placeholder to enforce size
                    ),
                  ),
                ),

              // 2. Content (Text + Grass)
              // Ensure consistent layout above the selection box
              Container(
                 alignment: Alignment.topCenter,
                 height: 50,
                 child: content,
              ),
              
              // 3. Interaction Overlay (Only for Normal state interaction)
              if (isNormal)
                Positioned.fill(
                  child: FractionallySizedBox(
                    widthFactor: 0.81, // Match selection box size?? 
                    // Wait, user said "Selection Area size/pos = Builder Area".
                    // If builder area is 81%/96%, then overlay should probably match?
                    // But Figma usually applies overlay to the whole interactive slot (49x50).
                    // User request: "빌더 영역을 변경... 선택 영역의 크기,위치는 빌더 영역과 동일"
                    // Assume Overlay should also follow this "Builder Size" if that's the visual bounds.
                    // Let's keep Overlay filling the *whole* slot for now to ensure touch feedback isn't weirdly clipped, 
                    // OR if "Builder Area" = Visual Area, then Overlay should match Visual Area.
                    // Given "builder area is reduced", I will constrain overlay to 81%/96% too.
                    heightFactor: 0.96,
                    child: AppInteractiveOverlay(
                      state: interactionState,
                      style: AppInteractionStyle.light,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
