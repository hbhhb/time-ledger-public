import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';
import 'package:time_ledger/core/theme/foundations/app_typography.dart';
import 'package:time_ledger/presentation/components/calendar/calendar_item_new.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';

class CalendarWeekHeader extends StatelessWidget {
  const CalendarWeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final appTypography = Theme.of(context).extension<AppTypography>()!;
    final weekDays = ['일', '월', '화', '수', '목', '금', '토'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays.map((day) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              day,
              style: appTypography.label2.regular.copyWith(
                color: appColors.labelAlternative,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CalendarMonthView extends ConsumerWidget {
  final DateTime focusedMonth;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime? firstDay;
  final DateTime? lastDay;

  const CalendarMonthView({
    super.key,
    required this.focusedMonth,
    required this.onDateSelected,
    this.selectedDate,
    this.firstDay,
    this.lastDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grassLevels = ref.watch(grassLevelsProvider);
    final daysInMonth = _daysInMonth(focusedMonth);
    // Align rows
    List<Widget> rows = [];
    List<Widget> currentWeek = [];

    // Calculate padding days (days before 1st of month)
    final firstWeekday = DateTime(focusedMonth.year, focusedMonth.month, 1).weekday;
    // DateTime.weekday returns 1(Mon)..7(Sun). We want 0(Sun)..6(Sat) or similar depending on start.
    // Standard: Sun(7)->0, Mon(1)->1, ...
    // If we start Week on Sunday:
    // Sunday(7) should be index 0. Monday(1) index 1.
    // Padding count = (weekday % 7).
    // e.g. 1st is Mon(1). Padding = 1 (Sun).
    // e.g. 1st is Sun(7). Padding = 7%7 = 0.
    final paddingDays = firstWeekday % 7;

    // Previous Month Fillers (Empty or formatted?)
    // Figma usually shows empty or inactive. User said "Inactive (Future)" but usually previous month is empty in this designs.
    // "States: Empty".
    for (int i = 0; i < paddingDays; i++) {
      currentWeek.add(const Expanded(child: CalendarItemNew(dateText: '', state: CalendarItemState.empty)));
    }

    for (var day in daysInMonth) {
      if (currentWeek.length == 7) {
        rows.add(Row(children: currentWeek));
        currentWeek = [];
      }

      final isSelected = selectedDate != null && isSameDay(day, selectedDate!);
      // Simple Future check: Day > Today (ignoring time)
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final isFuture = day.isAfter(today);

      final hasLogs = grassLevels.containsKey(day);

      CalendarItemState state = CalendarItemState.normal;
      if (isSelected) {
        state = CalendarItemState.selected;
      } else if (isFuture || !hasLogs) {
        state = CalendarItemState.inactive;
      }

      final grassLevel = grassLevels[day] ?? 0;

      currentWeek.add(
        Expanded(
          child: CalendarItemNew(
            dateText: day.day.toString(),
            state: state,
            grassLevel: grassLevel,
            isToday: day.year == now.year && day.month == now.month && day.day == now.day,
            onTap: () => onDateSelected(day),
          ),
        ),
      );
    }

    // Fill remaining
    while (currentWeek.length < 7) {
      currentWeek.add(const Expanded(child: CalendarItemNew(dateText: '', state: CalendarItemState.empty)));
    }
    rows.add(Row(children: currentWeek));

    return Column(
      children: rows,
    );
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final daysBefore = first.weekday % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = DateTime(month.year, month.month + 1, 0);
    final daysAfter = 7 - (last.weekday % 7) - 1; // Correction needed?
    // Actually we just need exact days of THIS month for the Item generation logic above.
    
    final days = <DateTime>[];
    final daysCount = DateUtils.getDaysInMonth(month.year, month.month);
    for (int i = 1; i <= daysCount; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    return days;
  }
}

class CalendarWeekView extends ConsumerWidget {
  final DateTime focusedDate; // Any date within the week
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarWeekView({
    super.key,
    required this.focusedDate,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grassLevels = ref.watch(grassLevelsProvider);
    final days = _daysInWeek(focusedDate);
    
    return Row(
      children: days.map((day) {
        final isSelected = selectedDate != null && isSameDay(day, selectedDate!);
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final isFuture = day.isAfter(today);

        CalendarItemState state = CalendarItemState.normal;
        final hasLogs = grassLevels.containsKey(day);
        if (isSelected) {
          state = CalendarItemState.selected;
        } else if (isFuture || !hasLogs) {
          state = CalendarItemState.inactive;
        }

        final grassLevel = grassLevels[day] ?? 0;

        return Expanded(
          child: CalendarItemNew(
            dateText: day.day.toString(),
            state: state,
            grassLevel: grassLevel,
            isToday: day.year == now.year && day.month == now.month && day.day == now.day,
            onTap: () => onDateSelected(day),
          ),
        );
      }).toList(),
    );
  }

  List<DateTime> _daysInWeek(DateTime date) {
    // Start of week (Sunday)
    // weekday: Mon(1)..Sun(7). Sun is 7.
    // if Sun(7), subtract 0. if Mon(1), subtract 1.
    final daysFromSunday = date.weekday % 7;
    final startOfWeek = date.subtract(Duration(days: daysFromSunday));
    
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) return false;
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

class CalendarStickyRow extends ConsumerWidget {
  final DateTime targetDate;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  final DateTime? displayedMonth;

  const CalendarStickyRow({
    super.key,
    required this.targetDate,
    required this.selectedDate,
    required this.onDateSelected,
    this.displayedMonth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grassLevels = ref.watch(grassLevelsProvider);
    final days = _daysInWeek(targetDate);
    final appColors = Theme.of(context).extension<AppColors>()!;
    // Note: Typography is used inside CalendarItemNew

    return Row(
      children: days.map((day) {
        final isSelected = selectedDate != null && isSameDay(day, selectedDate);
        
        // Future Check
        // Month Filter
        if (displayedMonth != null && day.month != displayedMonth!.month) {
             return const Expanded(
                child: CalendarItemNew(
                  dateText: '',
                  state: CalendarItemState.empty,
                ),
              );
        }

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final isFuture = day.isAfter(today);

        CalendarItemState state = CalendarItemState.normal;
        final hasLogs = grassLevels.containsKey(day);
        if (isSelected) {
          state = CalendarItemState.selected;
        } else if (isFuture || !hasLogs) {
          state = CalendarItemState.inactive;
        }

        final grassLevel = grassLevels[day] ?? 0;

        return Expanded(
          child: CalendarItemNew(
            dateText: day.day.toString(),
            state: state,
            grassLevel: grassLevel,
            isToday: day.year == now.year && day.month == now.month && day.day == now.day,
            onTap: () => onDateSelected(day),
          ),
        );
      }).toList(),
    );
  }

  List<DateTime> _daysInWeek(DateTime date) {
    // Start of week (Sunday)
    // weekday: Mon(1)..Sun(7).
    // If Sun(7) -> %7 = 0. Subtract 0 days. Correct.
    // If Mon(1) -> %7 = 1. Subtract 1 day. Correct.
    final daysFromSunday = date.weekday % 7;
    final startOfWeek = date.subtract(Duration(days: daysFromSunday));
    
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
}
extension DateTimeExtension on DateTime {
  DateTime get startOfWeek {
    return subtract(Duration(days: weekday % 7));
  }
}

class CalendarWeekTransition extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime? displayedMonth;

  const CalendarWeekTransition({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.displayedMonth,
  });

  @override
  State<CalendarWeekTransition> createState() => _CalendarWeekTransitionState();
}

class _CalendarWeekTransitionState extends State<CalendarWeekTransition> {
  late DateTime _currentDate;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(CalendarWeekTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!isSameDay(_currentDate.startOfWeek, widget.selectedDate.startOfWeek)) {
      _isForward = widget.selectedDate.isAfter(_currentDate);
      _currentDate = widget.selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeOutQuart,
      layoutBuilder: (child, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ...previousChildren,
            if (child != null) child,
          ],
        );
      },
      transitionBuilder: (child, animation) {
        final isEntering = child is CalendarStickyRow && 
                          (child.key as ValueKey<DateTime>).value == _currentDate.startOfWeek;

        if (isEntering) {
          // New Week: Slide (±50px) + Spring (easeOutQuart) + Fade In
          final beginOffset = _isForward ? const Offset(0, 1.0) : const Offset(0, -1.0);
          return SlideTransition(
            position: animation.drive(Tween<Offset>(
              begin: beginOffset,
              end: Offset.zero,
            )),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        } else {
          // Old Week: Fade Out (150ms)
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      },
      child: CalendarStickyRow(
        key: ValueKey(_currentDate.startOfWeek),
        targetDate: _currentDate,
        selectedDate: widget.selectedDate,
        onDateSelected: widget.onDateSelected,
        displayedMonth: widget.displayedMonth,
      ),
    );
  }
}
