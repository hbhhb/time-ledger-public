import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart'; // Not needed if we manual format
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/providers/providers.dart';

class WeeklyCalendar extends ConsumerStatefulWidget {
  const WeeklyCalendar({super.key});

  @override
  ConsumerState<WeeklyCalendar> createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends ConsumerState<WeeklyCalendar> {
  late PageController _pageController;
  // A generic "start of time" anchor to allow easier index calculation.
  // Using a Monday far in the past.
  final DateTime _anchorDate = DateTime(2020, 1, 6); // 2020-01-06 was Monday

  @override
  void initState() {
    super.initState();
    // Initialize controller will be done in didChangeDependencies or we can do it here if we read provider once.
    // But selectedDate can change.
    // We'll initialize it based on current selectedDate.
  }

  int _getIndexForDate(DateTime date) {
    final diff = date.difference(_anchorDate).inDays;
    return (diff / 7).floor();
  }

  DateTime _getDateForIndex(int index) {
    return _anchorDate.add(Duration(days: index * 7));
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final today = DateTime.now();
    
    // Normalize today to midnight for comparison (though not strictly necessary as long as logic is consistent)
    final now = DateTime(today.year, today.month, today.day);
    
    // Calculate max index implementation (Week containing Today)
    final todayIndex = _getIndexForDate(now);
    
    // Calculate current selected index
    final selectedIndex = _getIndexForDate(selectedDate);

    // Ensure controller is synced with selectedDate if it changed externally?
    // Or just initialize once.
    // A common pattern: if the user selects a date, we probably want to scroll to it.
    // But if we reconstruct PageController every build, we lose scroll state/animation.
    // Only recreate/jump if necessary.
    // Ideally, we store the `_pageController` in state.
    
    if (!_isControllerInitialized) {
       _pageController = PageController(initialPage: selectedIndex);
       _isControllerInitialized = true;
    } else {
       // If selectedDate changed and is not in current view, animate/jump
       if (_pageController.hasClients) {
          final currentPage = _pageController.page?.round() ?? selectedIndex;
          if (currentPage != selectedIndex) {
            // Check if this change was triggered by the user swiping (which we don't want to revert)
            // vs externally changing date.
            // If the user tapped a date in a different week, we should scroll there.
            // If the user swiped, `selectedIndex` might still be the old one UNTIL they tap.
            // Wait, if user swipes, `selectedDate` does NOT change automatically in this design.
            // So if `selectedDate` changed, it MUST be an external explicit action (or tap).
            // So we should jump/animate to it.
            _pageController.animateToPage(
              selectedIndex, 
              duration: const Duration(milliseconds: 300), 
              curve: Curves.easeInOut
            );
          }
       }
    }

    const weekDays = ['일', '월', '화', '수', '목', '금', '토'];

    return Container(
      color: AppColorsLegacy.bgPrimary,
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Weekday Labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekDays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColorsLegacy.fgTertiary, 
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8), // Gap between WkDay and Date

          // Date PageView
          SizedBox(
            height: 50, // Fixed height for the items (50px)
            child: PageView.builder(
              controller: _pageController,
              itemCount: todayIndex + 1,
              onPageChanged: (index) {},
              itemBuilder: (context, index) {
                final weekMonday = _getDateForIndex(index);
                final weekDates = List.generate(7, (i) => weekMonday.add(Duration(days: i)));
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weekDates.map((date) {
                      final isSelected = _isSameDay(date, selectedDate);
                      final isFuture = date.isAfter(now);
                      
                      return Expanded(
                        child: GestureDetector(
                          onTap: isFuture ? null : () {
                             ref.read(selectedDateProvider.notifier).state = date;
                          },
                          child: _CalendarItem(
                            date: date, 
                            isSelected: isSelected, 
                            isFuture: isFuture,
                            ref: ref
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isControllerInitialized = false;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _CalendarItem extends ConsumerWidget {
  final DateTime date;
  final bool isSelected;
  final bool isFuture;
  final WidgetRef ref;

  const _CalendarItem({
    required this.date,
    required this.isSelected,
    required this.isFuture,
    required this.ref,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyLogsStream = ref.read(getDailyLogsUseCaseProvider).execute(date);
    
    return StreamBuilder<List<LogEntity>>(
      stream: dailyLogsStream,
      builder: (context, snapshot) {
        int netMinutes = 0;
        bool hasRecord = false;

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          hasRecord = true;
          final logs = snapshot.data!;
          for (var log in logs) {
            if (log.snapshotValue == TimeValue.productive) {
              netMinutes += log.duration;
            } else if (log.snapshotValue == TimeValue.waste) {
              netMinutes -= log.duration;
            }
          }
        }

        // Determine Grass Level Logic
        Color? grassColor;
        
        if (hasRecord) {
           final double netHours = netMinutes / 60.0;
           
           if (netHours > 8) {
             grassColor = AppColorsLegacy.stepGrassLv4;
           } else if (netHours > 5) {
             grassColor = AppColorsLegacy.stepGrassLv3;
           } else if (netHours > 2) {
             grassColor = AppColorsLegacy.stepGrassLv2;
           } else {
             // Net Time <= 2 (Includes 0 and Negative)
             grassColor = AppColorsLegacy.stepGrassLv1;
           }
        } else {
          // No Record -> No Bar
          grassColor = null;
        }

        Color textColor;
        FontWeight fontWeight;
        
        if (isFuture) {
          textColor = AppColorsLegacy.fgTertiary;
          fontWeight = FontWeight.w400;
        } else if (isSelected) {
          textColor = AppColorsLegacy.fgPrimary;
          fontWeight = FontWeight.w600;
        } else {
          textColor = AppColorsLegacy.fgSecondary;
          fontWeight = FontWeight.w500;
        }

        return Container(
          height: 50, // Fixed height per spec
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected ? Border.all(color: AppColorsLegacy.fgSlight, width: 0.5) : null,
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                style: TextStyle(
                  fontSize: 16, // Font size 16
                  fontWeight: fontWeight,
                  color: textColor,
                  fontFamily: 'Pretendard',
                  letterSpacing: -0.32,
                  height: 1.5, // 150% line height
                ),
              ),
              const SizedBox(height: 2), // Gap 2px
              
              // Grass Bar Indicator
              if (grassColor != null)
                Container(
                  width: 14, // Fixed 14px 
                  height: 6, // Fixed 6px
                  decoration: BoxDecoration(
                    color: grassColor,
                    borderRadius: BorderRadius.circular(3), // Rounded (half of height)
                  ),
                )
              else
                const SizedBox(height: 6), // Placeholder matches bar height (6px)
            ],
          ),
        );
      },
    );
  }
}
