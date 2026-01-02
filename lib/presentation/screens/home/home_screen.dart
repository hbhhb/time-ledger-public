import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/presentation/components/calendar/sticky_calendar_delegate.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/screens/home/widgets/sliver_log_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _calendarAnimationController;
  bool _isAutoScrolling = false;

  // Height Constants
  static const double homeHeaderHeight = 60.0;
  static const double weekHeaderHeight = 30.0;
  static const double rowHeight = 50.0;
  static const double delegateBottomPadding = 12.0;
  
  static const double dayHeaderHeight = 32.0;
  static const double headerGapHeight = 8.0;
  static const double logItemHeight = 56.0;
  static const double dayGapHeight = 24.0;
  static const double logListTopPadding = 12.0;
  static const double boxGap = 4.0;

  @override
  void initState() {
    super.initState();
    _calendarAnimationController = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _calendarAnimationController.dispose();
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0.0;
      final offset = _scrollController.offset;

      // Only collapse/expand if not auto-scrolling
      if (!_isAutoScrolling) {
        if (delta > 2.0 && offset > 0) {
          if (!_calendarAnimationController.isAnimating && _calendarAnimationController.value < 1.0) {
            _calendarAnimationController.animateTo(1.0, curve: Curves.easeOutQuart);
          }
        } else if (delta < -2.0 && offset <= 0) {
          if (!_calendarAnimationController.isAnimating && _calendarAnimationController.value > 0.0) {
            _calendarAnimationController.animateTo(0.0, curve: Curves.easeOutQuart);
          }
        }
      }

      // Real-time synchronization
      if (!_isAutoScrolling) {
        _syncDateWithScroll();
      }
    }
  }

  void _syncDateWithScroll() {
    final sortedDates = ref.read(sortedDatesProvider);
    final groupedLogs = ref.read(groupedLogsProvider);
    if (sortedDates.isEmpty) return;

    final offset = _scrollController.offset;
    final progress = _calendarAnimationController.value;
    final selectedDate = ref.read(selectedDateProvider);

    // Header heights mapping
    final rows = _calculateRowCount(selectedDate ?? DateTime.now());
    final fullHeight = homeHeaderHeight + weekHeaderHeight + (rows * rowHeight) + delegateBottomPadding;
    final collHeight = homeHeaderHeight + weekHeaderHeight + rowHeight + delegateBottomPadding;

    // Current dynamic maxExtent of the calendar sliver
    final currentMaxExtent = collHeight + (fullHeight - collHeight) * (1.0 - progress);
    
    // The visual height of the pinned header
    final currentHeaderHeight = (currentMaxExtent - offset).clamp(collHeight, currentMaxExtent);

    // The line where list content meets the calendar bottom
    final syncPointInScroll = offset + currentHeaderHeight;
    
    // The scroll offset where list content (padding + first item) actually starts
    final listStartOffset = currentMaxExtent + boxGap + logListTopPadding;
    
    // Shift the detector slightly (10px) to favor the upcoming day as it enters the view
    double relativeOffset = syncPointInScroll - listStartOffset + 10.0;
    
    if (relativeOffset <= 0) {
      _updateSelectedDate(sortedDates[0]);
      return;
    }

    for (final date in sortedDates) {
      final logs = groupedLogs[date] ?? [];
      final dayHeight = dayHeaderHeight + headerGapHeight + (logs.length * logItemHeight) + dayGapHeight;
      
      if (relativeOffset < dayHeight) {
        _updateSelectedDate(date);
        return;
      }
      relativeOffset -= dayHeight;
    }
  }

  void _updateSelectedDate(DateTime newDate) {
    final current = ref.read(selectedDateProvider);
    if (current != null && current.year == newDate.year && current.month == newDate.month && current.day == newDate.day) return;
    
    // Update state. If it crosses a week boundary, Step 3 animation triggers.
    ref.read(selectedDateProvider.notifier).updateDate(newDate);
  }

  int _calculateRowCount(DateTime date) {
    final first = DateTime(date.year, date.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    final firstWeekday = first.weekday % 7; // Sunday = 0, matches delegate
    final totalCells = firstWeekday + daysInMonth;
    return (totalCells / 7).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            _handleScrollNotification(notification);
            return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(), 
            slivers: [
              AnimatedBuilder(
                animation: _calendarAnimationController,
                builder: (context, child) {
                  return SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyCalendarDelegate(
                      focusedDate: selectedDate ?? DateTime.now(), 
                      selectedDate: selectedDate,
                      animationProgress: _calendarAnimationController.value,
                      onDateSelected: (date) {
                        ref.read(selectedDateProvider.notifier).updateDate(date);
                        _scrollToDate(date);
                      },
                      onSwipeUp: () {
                        if (!_calendarAnimationController.isAnimating && _calendarAnimationController.value < 1.0) {
                          _calendarAnimationController.animateTo(1.0, curve: Curves.easeOutQuart);
                        }
                      },
                      onSwipeDown: () {
                        if (!_calendarAnimationController.isAnimating && _calendarAnimationController.value > 0.0) {
                          _calendarAnimationController.animateTo(0.0, curve: Curves.easeOutQuart);
                        }
                      },
                      topPadding: 0, 
                    ),
                  );
                },
              ),
  
              const SliverToBoxAdapter(
                child: SizedBox(height: boxGap),
              ),
  
              const SliverLogList(),

              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, ref, child) {
                    final selectedDate = ref.watch(selectedDateProvider) ?? DateTime.now();
                    final sortedDates = ref.watch(sortedDatesProvider);
                    final groupedLogs = ref.watch(groupedLogsProvider);

                    return AnimatedBuilder(
                      animation: _calendarAnimationController,
                      builder: (context, child) {
                        // 1. Screen & SafeArea Dimensions
                        final mediaQuery = MediaQuery.of(context);
                        final screenHeight = mediaQuery.size.height;
                        final topSafeArea = mediaQuery.padding.top;
                        final bottomSafeArea = mediaQuery.padding.bottom;
                        final bottomNavHeight = 64.0; // Fixed BottomNavigationBar height
                        final bottomNavTotalHeight = bottomNavHeight + bottomSafeArea;

                        // 2. Current Calendar Height
                        final progress = _calendarAnimationController.value;
                        final rows = _calculateRowCount(selectedDate);
                        final fullHeight = homeHeaderHeight + weekHeaderHeight + (rows * rowHeight) + delegateBottomPadding;
                        final collHeight = homeHeaderHeight + weekHeaderHeight + rowHeight + delegateBottomPadding;
                        final currentCalendarHeight = collHeight + (fullHeight - collHeight) * (1.0 - progress);

                        // 3. Last Item Content Height
                        double lastItemContentHeight = 0.0;
                        if (sortedDates.isNotEmpty) {
                          final lastDate = sortedDates.last; // The last date (e.g., 1st day of month)
                          final logs = groupedLogs[lastDate] ?? [];
                          // Header + Gap + Logs + BottomGap
                          lastItemContentHeight = dayHeaderHeight + headerGapHeight + (logs.length * logItemHeight) + dayGapHeight;
                        }

                        // 4. Calculate Padding
                        // Padding = ScreenHeight - TopSafeArea - CurrentCalendarHeight - LastItemContentHeight - BottomNavTotalHeight
                        double calculatedPadding = screenHeight 
                                                       - topSafeArea 
                                                       - currentCalendarHeight 
                                                       - lastItemContentHeight 
                                                       - bottomNavTotalHeight;

                        // 5. Adjust for MonthNavigationButton
                        // If it exists, it essentially acts as "padding" content, so we subtract its height/margin from the artificial padding.
                        final hasPreviousLogs = ref.watch(hasLogsInPreviousMonthProvider);
                        if (hasPreviousLogs) {
                          const buttonHeight = 72.0; // Text(~24) + Padding(48)
                          const buttonTopMargin = 24.0; // dayGapHeight equivalent
                          calculatedPadding -= (buttonHeight + buttonTopMargin);
                        }

                        // Ensure non-negative
                        return SizedBox(
                          height: calculatedPadding > 0 ? calculatedPadding : 0,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToDate(DateTime date) {
    final sortedDates = ref.read(sortedDatesProvider);
    final groupedLogs = ref.read(groupedLogsProvider);
    
    // Find index of the date
    final index = sortedDates.indexWhere((d) => 
      d.year == date.year && d.month == date.month && d.day == date.day);
    
    if (index == -1) return;

    final rows = _calculateRowCount(date);
    final expandedHeight = homeHeaderHeight + weekHeaderHeight + (rows * rowHeight) + delegateBottomPadding;
    final collapsedHeight = homeHeaderHeight + weekHeaderHeight + rowHeight + delegateBottomPadding;
    final listStartInScroll = expandedHeight + boxGap + logListTopPadding;

    double targetRelativeOffset = 0.0;
    for (int i = 0; i < index; i++) {
        final d = sortedDates[i];
        final logs = groupedLogs[d] ?? [];
        targetRelativeOffset += dayHeaderHeight + headerGapHeight + (logs.length * logItemHeight) + dayGapHeight;
    }

    // scrollOffset = targetRelativeOffset + boxGap + logListTopPadding
    // Since the Calendar Header (SliverPersistentHeader) dynamically resizes (via AnimationController) and pushes the content down,
    // the layout position of the list items changes relative to the scroll view top.
    // However, the "scrollable distance" to bring an item to the bottom of the header is constant:
    // It's just the gaps between the header and the list items.
    
    final double targetOffset = targetRelativeOffset + boxGap + logListTopPadding;

    _isAutoScrolling = true;
    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutQuart,
    ).then((_) {
      _isAutoScrolling = false;
    });
  }
}
