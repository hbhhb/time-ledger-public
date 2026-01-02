import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/category_entity.dart';
import 'package:time_ledger/domain/entities/log_entity.dart'; // import
import 'package:time_ledger/domain/repositories/app_repository.dart';
import 'package:time_ledger/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';
import 'dart:math'; // import

final seedCategoriesProvider = FutureProvider<void>((ref) async {
  final repo = ref.read(categoryRepositoryProvider);
  final existing = await repo.getAllCategories();
  
  if (existing.isNotEmpty) return;

  final defaults = [
    const CategoryEntity(id: '1', name: '업무', icon: '💻', defaultValue: TimeValue.productive, sortOrder: 0),
    const CategoryEntity(id: '2', name: '공부', icon: '📝', defaultValue: TimeValue.productive, sortOrder: 1),
    const CategoryEntity(id: '3', name: '운동', icon: '🏃‍♂️', defaultValue: TimeValue.productive, sortOrder: 2),
    const CategoryEntity(id: '4', name: '독서', icon: '📖', defaultValue: TimeValue.productive, sortOrder: 3),
    const CategoryEntity(id: '5', name: '글쓰기', icon: '✍️', defaultValue: TimeValue.productive, sortOrder: 4),

    const CategoryEntity(id: '10', name: '식사', icon: '🍚', defaultValue: TimeValue.productive, sortOrder: 10),
    const CategoryEntity(id: '11', name: '수면', icon: '🛌', defaultValue: TimeValue.productive, sortOrder: 11),
    const CategoryEntity(id: '12', name: '휴식', icon: '☕', defaultValue: TimeValue.productive, sortOrder: 12),
    
    const CategoryEntity(id: '20', name: 'SNS ∙ 숏폼', icon: '📱', defaultValue: TimeValue.waste, sortOrder: 20),
    const CategoryEntity(id: '21', name: '게임', icon: '🎮', defaultValue: TimeValue.waste, sortOrder: 21),
    const CategoryEntity(id: '22', name: '유튜브 ∙ OTT', icon: '🍿', defaultValue: TimeValue.waste, sortOrder: 22),
    const CategoryEntity(id: '23', name: '웹서핑 ∙ 쇼핑', icon: '🛍️', defaultValue: TimeValue.waste, sortOrder: 23),
    const CategoryEntity(id: '24', name: '누워있기', icon: '🛌', defaultValue: TimeValue.waste, sortOrder: 24),
    const CategoryEntity(id: '25', name: '기타', icon: '💬', defaultValue: TimeValue.waste, sortOrder: 25),
  ];

  // 1. Ensure Categories Exist
  for (final cat in defaults) {
    if (!existing.any((e) => e.name == cat.name)) { // Simple check by name
       await repo.createCategory(cat);
    }
  }

  // 2. Random Logs Seeder (Dev Only) 
  final logRepo = ref.read(logRepositoryProvider);
  
  // Only seed if today has no logs (Assume empty if today is empty for simplicity of this dev tool)
  final todayLogs = await logRepo.getLogsByDate(DateTime.now());
  if (todayLogs.isNotEmpty) return;

  final allCats = await repo.getAllCategories();
  if (allCats.isEmpty) return;

  final rng = Random();
  final today = DateTime.now();

  // Calculate start date: Last 15 days of the previous month
  final lastDayPrevMonth = DateTime(today.year, today.month, 0);
  final startDate = lastDayPrevMonth.subtract(const Duration(days: 14));

  // Iterate from startDate to today (inclusive)
  for (var day = startDate; day.compareTo(today) <= 0; day = day.add(const Duration(days: 1))) {
     // 10% chance to skip (Empty day)
     if (rng.nextDouble() < 0.1) continue;

     // 3 to 6 logs per day
     final count = rng.nextInt(4) + 3; 
     
     // Start from 08:00
     var currentTime = DateTime(day.year, day.month, day.day, 8, 0);

     for (int i = 0; i < count; i++) {
        // Pick random category
        final cat = allCats[rng.nextInt(allCats.length)];
        
        // Random duration: 30, 45, 60, 90, 120
        final durations = [30, 45, 60, 90, 120];
        final duration = durations[rng.nextInt(durations.length)];
        
        // Add some gap 0-60 mins
        final gap = rng.nextInt(60);
        currentTime = currentTime.add(Duration(minutes: gap));

        final log = LogEntity(
          id: const Uuid().v4(),
          targetDate: currentTime,
          categoryId: cat.id,
          duration: duration,
          snapshotName: cat.name,
          snapshotIcon: cat.icon,
          snapshotValue: cat.defaultValue,
          createdAt: DateTime.now(),
        );

        await logRepo.createLog(log);
        
        // Advance time by duration
        currentTime = currentTime.add(Duration(minutes: duration));
     }
  }
});
