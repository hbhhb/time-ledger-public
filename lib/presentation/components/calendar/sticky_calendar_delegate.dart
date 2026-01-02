import 'dart:math';
import 'package:flutter/material.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/presentation/components/calendar/calendar_view_new.dart';
import 'package:time_ledger/presentation/screens/home/widgets/home_header.dart'; // Import HomeHeader

class StickyCalendarDelegate extends SliverPersistentHeaderDelegate {
  final DateTime focusedDate;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final double topPadding;
  final double animationProgress; // 0.0 = Month (Expanded), 1.0 = Week (Collapsed)

  static const double _rowHeight = 50.0;
  static const double _weekHeaderHeight = 30.0;
  static const double _homeHeaderHeight = 60.0;
  static const double _shadowBuffer = 20.0;

  StickyCalendarDelegate({
    required this.focusedDate,
    required this.onDateSelected,
    required this.animationProgress,
    this.onSwipeUp,
    this.onSwipeDown,
    this.selectedDate,
    this.topPadding = 0.0,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    
    // Use animationProgress directly (0.0 = Expanded, 1.0 = Collapsed)
    final double progress = animationProgress;
    
    DateTime targetDate = focusedDate;
    if (selectedDate != null && 
        selectedDate!.year == focusedDate.year && 
        selectedDate!.month == focusedDate.month) {
      targetDate = selectedDate!;
    }
    
    final firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    final int firstWeekday = firstDayOfMonth.weekday % 7; 
    final int targetDayIndex = targetDate.day - 1 + firstWeekday;
    final int targetRowIndex = targetDayIndex ~/ 7;
    
    final int totalRows = _calculateRowCount(focusedDate);
    final int clampedRowIndex = targetRowIndex.clamp(0, totalRows - 1);

    final double topHeaderHeight = _homeHeaderHeight + _weekHeaderHeight;

    // --- Header Construction ---
    final Widget headerWidget = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
             SizedBox(
              height: _homeHeaderHeight,
              child: const HomeHeader(),
            ),
             SizedBox( 
              height: _weekHeaderHeight,
              child: const CalendarWeekHeader(),
            ),
          ],
        ),
      ),
    );

    // --- Main Rendering ---
    if (progress == 1.0) {
      // Weekly View: Single Row with Transitions
      return RepaintBoundary(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 200) {
              onSwipeDown?.call();
            } else if (details.primaryVelocity! < -200) {
              onSwipeUp?.call();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: appColors.backgroundNormalNormal,
              border: Border(
                bottom: BorderSide(
                  color: appColors.lineNormalAlternative,
                  width: 1.0,
                ),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: topHeaderHeight + topPadding,
                  left: 12,
                  right: 12,
                  height: _rowHeight,
                  child: CalendarWeekTransition(
                    selectedDate: selectedDate ?? DateTime.now(),
                    onDateSelected: onDateSelected,
                    displayedMonth: focusedDate,
                  ),
                ),
                headerWidget,
              ],
            ),
          ),
        ),
      );
    }

    // Monthly View: Stack of Rows during animation or expanded
    List<Widget> rowWidgets = [];
    Widget? selectedRowWidget;
    
    for (int i = 0; i < totalRows; i++) {
       final isSelectedRow = i == clampedRowIndex;
       
       final double expandedTop = i * _rowHeight;
       final double collapsedTop = 0.0;
       final double currentTop = (expandedTop * (1 - progress)) + (collapsedTop * progress);

       double opacity = 1.0;
       if (!isSelectedRow) {
         opacity = (1.0 - progress).clamp(0.0, 1.0);
       }
       
       if (opacity <= 0.01 && !isSelectedRow) continue;
       
       final rowStartDate = firstDayOfMonth.add(Duration(days: (i * 7) - firstWeekday));
       final rowTargetDate = rowStartDate.add(const Duration(days: 1));

       final widget = Positioned(
        top: topHeaderHeight + topPadding + currentTop,
        left: 12,
        right: 12,
        height: _rowHeight,
        child: Opacity(
          opacity: opacity,
          child: CalendarStickyRow(
            targetDate: rowTargetDate,
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
            displayedMonth: focusedDate,
          ),
        ),
      );

      if (isSelectedRow) {
        selectedRowWidget = widget;
      } else {
        rowWidgets.add(widget);
      }
    }
    
    if (selectedRowWidget != null) {
      rowWidgets.add(selectedRowWidget);
    }
    
    return RepaintBoundary(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 200) {
            onSwipeDown?.call();
          } else if (details.primaryVelocity! < -200) {
            onSwipeUp?.call();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: appColors.backgroundNormalNormal,
            border: Border(
              bottom: BorderSide(
                color: appColors.lineNormalAlternative,
                width: 1.0,
              ),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...rowWidgets,
              headerWidget,
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent {
    final rows = _calculateRowCount(focusedDate);
    final double fullHeight = _homeHeaderHeight + _weekHeaderHeight + (rows * _rowHeight) + 12 + topPadding;
    final double collHeight = _homeHeaderHeight + _weekHeaderHeight + _rowHeight + 12 + topPadding;
    
    // Physically interpolate the extent based on progress
    return collHeight + (fullHeight - collHeight) * (1.0 - animationProgress);
  }

  @override
  double get minExtent => maxExtent;

  @override
  bool shouldRebuild(covariant StickyCalendarDelegate oldDelegate) {
    return oldDelegate.focusedDate != focusedDate ||
        oldDelegate.selectedDate != selectedDate ||
        oldDelegate.topPadding != topPadding ||
        oldDelegate.animationProgress != animationProgress ||
        oldDelegate.onSwipeUp != onSwipeUp ||
        oldDelegate.onSwipeDown != onSwipeDown;
  }

  int _calculateRowCount(DateTime date) {
    final first = DateTime(date.year, date.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final firstWeekday = first.weekday % 7;
    final totalCells = firstWeekday + daysInMonth;
    return (totalCells / 7).ceil();
  }
}
