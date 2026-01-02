import 'package:drift/drift.dart';
import 'package:time_ledger/core/database/app_database.dart';
import 'package:time_ledger/core/utils/enums.dart';
import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';

class DriftLogRepository implements LogRepository {
  final AppDatabase _db;

  DriftLogRepository(this._db);

  LogEntity _mapToEntity(Log row, Category? category) {
    return LogEntity(
      id: row.id,
      targetDate: row.targetDate,
      categoryId: row.categoryId,
      duration: row.duration,
      snapshotName: row.snapshotName,
      snapshotIcon: row.snapshotIcon,
      snapshotValue: row.snapshotValue,
      categoryIcon: category?.icon,
      categoryName: category?.name,
      memo: row.memo,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<void> createLog(LogEntity log) async {
    await _db.into(_db.logs).insert(
          LogsCompanion(
            id: Value(log.id),
            targetDate: Value(log.targetDate),
            categoryId: Value(log.categoryId),
            duration: Value(log.duration),
            snapshotName: Value(log.snapshotName),
            snapshotIcon: Value(log.snapshotIcon),
            snapshotValue: Value(log.snapshotValue),
            memo: Value(log.memo),
            createdAt: Value(log.createdAt),
          ),
        );
  }

  @override
  Future<void> deleteLog(String id) async {
    await (_db.delete(_db.logs)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<LogEntity>> getLogsByDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1));

    final query = _db.select(_db.logs).join([
      leftOuterJoin(_db.categories, _db.categories.id.equalsExp(_db.logs.categoryId)),
    ])
      ..where(_db.logs.targetDate.isBetween(Variable(start), Variable(end)))
      ..orderBy([OrderingTerm(expression: _db.logs.createdAt, mode: OrderingMode.desc)]);

    final rows = await query.get();
    
    return rows.map((row) {
      return _mapToEntity(
        row.readTable(_db.logs),
        row.readTableOrNull(_db.categories),
      );
    }).toList();
  }

  @override
  Future<void> updateLog(LogEntity log) async {
    await (_db.update(_db.logs)..where((tbl) => tbl.id.equals(log.id))).write(
      LogsCompanion(
        targetDate: Value(log.targetDate),
        categoryId: Value(log.categoryId),
        duration: Value(log.duration),
        snapshotName: Value(log.snapshotName),
        snapshotIcon: Value(log.snapshotIcon),
        snapshotValue: Value(log.snapshotValue),
        memo: Value(log.memo),
      ),
    );
  }

  @override
  Stream<List<LogEntity>> watchLogsByDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1));

    final query = _db.select(_db.logs).join([
      leftOuterJoin(_db.categories, _db.categories.id.equalsExp(_db.logs.categoryId)),
    ])
      ..where(_db.logs.targetDate.isBetween(Variable(start), Variable(end)))
      ..orderBy([OrderingTerm(expression: _db.logs.createdAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return _mapToEntity(
          row.readTable(_db.logs),
          row.readTableOrNull(_db.categories),
        );
      }).toList();
    });
  }

  @override
  Stream<List<LogEntity>> watchLogsInRange(DateTime startDate, DateTime endDate) {
    final query = _db.select(_db.logs).join([
      leftOuterJoin(_db.categories, _db.categories.id.equalsExp(_db.logs.categoryId)),
    ])
      ..where(_db.logs.targetDate.isBetween(Variable(startDate), Variable(endDate)))
      ..orderBy([OrderingTerm(expression: _db.logs.targetDate, mode: OrderingMode.desc), OrderingTerm(expression: _db.logs.createdAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return _mapToEntity(
          row.readTable(_db.logs),
          row.readTableOrNull(_db.categories),
        );
      }).toList();
    });
  }

  @override
  Future<void> updateLogSnapshots(String categoryId, {required TimeValue newValue}) async {
    await (_db.update(_db.logs)..where((tbl) => tbl.categoryId.equals(categoryId))).write(
      LogsCompanion(
        snapshotValue: Value(newValue),
      ),
    );
  }

  @override
  Future<void> unlinkLogsByCategoryId(String categoryId) async {
    await (_db.update(_db.logs)..where((tbl) => tbl.categoryId.equals(categoryId))).write(
      const LogsCompanion(
        categoryId: Value(null),
      ),
    );
  }

  @override
  Future<void> deleteLogsByCategoryId(String categoryId) async {
    await (_db.delete(_db.logs)..where((tbl) => tbl.categoryId.equals(categoryId))).go();
  }
}
