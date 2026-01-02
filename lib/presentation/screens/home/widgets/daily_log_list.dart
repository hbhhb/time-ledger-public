import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/presentation/providers/home_providers.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:time_ledger/presentation/screens/home/widgets/log_list_item.dart';

// Provider to fetch logs for a wide range (e.g. +/- 365 days from today)
// We use a fixed range around "now" to simulate infinite list for now.
// Only invalidates if we really need to (e.g. manual reload or logs change).
final logListRangeProvider = StreamProvider<List<LogEntity>>((ref) {
  // Fetch +/- 1 year of logs to cover most use cases.
  // In a real infinite scroll app, we'd paginate.
  final now = DateTime.now();
  final start = now.subtract(const Duration(days: 365));
  final end = now.add(const Duration(days: 365));
  return ref.watch(getLogsInRangeUseCaseProvider).execute(start, end);
});

class LogListView extends ConsumerStatefulWidget {
  const LogListView({super.key});

  @override
  ConsumerState<LogListView> createState() => _LogListViewState();
}

class _LogListViewState extends ConsumerState<LogListView> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  bool _isSyncing = false; // Guard to prevent recursive updates
  bool _hasInitialScrolled = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onScrollPositionChanged);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onScrollPositionChanged);
    super.dispose();
  }

  void _onScrollPositionChanged() {
    if (_isSyncing) return;

    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    // Find the item with the smallest index that is visible (min index)
    // Actually we want the top item.
    final firstVisible = positions.reduce((a, b) => a.index < b.index ? a : b);
    
    // Get the Date associated with this index
    final date = _getDateFromIndex(firstVisible.index);
    if (date != null) {
      final currentSelected = ref.read(selectedDateProvider);
      
      // Only update if date changed and is different
      if (!_isSameDay(date, currentSelected)) {
        // We update the provider, which might trigger jumpTo.
        // But if user is scrolling, we might not want to jump immediately?
        // Let's rely on provider update.
        // Note: Updating provider will trigger the listener below.
        // We set _isSyncing = true there? No, here we are naturally scrolling.
        // If we update provider, the listener below fires and calls `jumpTo`.
        // `jumpTo` will snap the list to the header. This might feel jerky if user is dragging.
        // Optimization: Don't update provider while dragging? 
        // We can't easily detect dragging here.
        // For now, let's update.
        ref.read(selectedDateProvider.notifier).updateDate(date);
      }
    }
  }

  DateTime? _getDateFromIndex(int index) {
    // We need access to the sortedDates list.
    // Ideally we store it in the state or access via provider if available.
    // Helper method will access it from the AsyncValue data if possible or passed in build.
    // For this design, we'll store the current map keys in a member variable during build.
    if (_sortedDates.isEmpty || index >= _sortedDates.length) return null;
    return _sortedDates[index];
  }

  List<DateTime> _sortedDates = [];

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(logListRangeProvider);
    
    // Listen to selected date changes to scroll to that date
    ref.listen(selectedDateProvider, (prev, next) {
      if (_sortedDates.isEmpty) return;
      
      // Find index of next
      final index = _sortedDates.indexWhere((d) => _isSameDay(d, next));
      if (index != -1) {
        // Prevent loop?
        // If we are here because of _onScrollPositionChanged, we might not want to jump?
        // But _onScrollPositionChanged updates the provider.
        // If we jump, it snaps.
        // Let's try attempting jump. Use _isSyncing to avoid double processing if needed.
        _itemScrollController.jumpTo(index: index);
      }
    });

    return logsAsync.when(
      data: (logs) {
        if (logs.isEmpty) {
          return const Center(
            child: Text(
              "기록이 없습니다.",
              style: TextStyle(
                fontSize: 14,
                color: AppColorsLegacy.fgTertiary,
                fontFamily: 'Pretendard',
              ),
            ),
          );
        }

        // Group Logs
        final Map<DateTime, List<LogEntity>> groupedLogs = {};
        for (var log in logs) {
          final dateKey = DateTime(log.targetDate.year, log.targetDate.month, log.targetDate.day);
          if (!groupedLogs.containsKey(dateKey)) {
            groupedLogs[dateKey] = [];
          }
          groupedLogs[dateKey]!.add(log);
        }

        _sortedDates = groupedLogs.keys.toList()..sort((a, b) => b.compareTo(a)); // Newest first

        // Initial Scroll to Selected Date
        // We only want to do this ONCE when data first loads or if we need to sync.
        // Since we are in build(), be validation.
        // A better place is in a useEffect or state init, but we rely on data loading.
        // We can use a flag.
        if (!_hasInitialScrolled && _sortedDates.isNotEmpty) {
           final selected = ref.read(selectedDateProvider);
           final index = _sortedDates.indexWhere((d) => _isSameDay(d, selected));
           if (index != -1) {
             WidgetsBinding.instance.addPostFrameCallback((_) {
               if (_itemScrollController.isAttached) {
                 _itemScrollController.jumpTo(index: index);
                 _hasInitialScrolled = true;
               }
             });
           } else {
             _hasInitialScrolled = true; // Mark done if not found
           }
        }

        return ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          padding: EdgeInsets.only(
            left: 24, 
            right: 24, 
            top: 12, 
            bottom: MediaQuery.of(context).size.height * 0.8, // Allow last item to reach top
          ),
          itemCount: _sortedDates.length,
          itemBuilder: (context, index) {
            final date = _sortedDates[index];
            final dayLogs = groupedLogs[date]!;
            
            // Calculate Totals
            int prodMin = 0;
            int wasteMin = 0;
            for (var log in dayLogs) {
              if (log.snapshotValue == TimeValue.productive) prodMin += log.duration;
              if (log.snapshotValue == TimeValue.waste) wasteMin += log.duration;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DateHeader(
                  date: date,
                  totalProductiveMinutes: prodMin,
                  totalWasteMinutes: wasteMin,
                ),
                const SizedBox(height: 8),
                ...dayLogs.map((log) => LogListItem(log: log)),
                const SizedBox(height: 24), // Spacing between days
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime date;
  final int totalProductiveMinutes;
  final int totalWasteMinutes;

  const _DateHeader({
    required this.date,
    required this.totalProductiveMinutes,
    required this.totalWasteMinutes,
  });

  String _formatDuration(int minutes, {bool isNegative = false}) {
    if (minutes == 0) return "-";
    final d = Duration(minutes: minutes);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    String text = "";
    if (h > 0) text += "${h}시간 ";
    if (m > 0) text += "${m}분";
    text = text.trim();
    return isNegative ? "-$text" : text;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    
    if (target == today) {
      return "${date.day}일 오늘";
    }
    // "12일 수요일"
    final weekdayNames = ["월", "화", "수", "목", "금", "토", "일"];
    return "${date.day}일 ${weekdayNames[date.weekday - 1]}요일";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _formatDate(date),
            style: const TextStyle(
              fontSize: 14,
              color: AppColorsLegacy.fgTertiary,
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 1,
              color: AppColorsLegacy.fgSlight,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            _formatDuration(totalProductiveMinutes),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColorsLegacy.fgPrimary, 
              fontFamily: 'Pretendard',
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDuration(totalWasteMinutes, isNegative: true),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColorsLegacy.fgTertiary,
              fontFamily: 'Pretendard',
            ),
          ),
        ],
      ),
    );
  }
}
