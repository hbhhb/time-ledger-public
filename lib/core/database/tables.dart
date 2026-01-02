import 'package:drift/drift.dart';
import 'package:time_ledger/core/utils/enums.dart';

// Type Converters
class TimeValueConverter extends TypeConverter<TimeValue, int> {
  const TimeValueConverter();

  @override
  TimeValue fromSql(int fromDb) => TimeValue.values[fromDb];

  @override
  int toSql(TimeValue value) => value.index;
}

class Categories extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get name => text()();
  TextColumn get icon => text()(); // Emoji or SVG path
  IntColumn get defaultValue => integer().map(const TimeValueConverter())();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  
  @override
  Set<Column> get primaryKey => {id};
}

class Logs extends Table {
  TextColumn get id => text()(); // UUID v4
  DateTimeColumn get targetDate => dateTime()();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  IntColumn get duration => integer()(); // 분(minutes) 단위
  
  // Snapshot Columns
  TextColumn get snapshotName => text()();
  TextColumn get snapshotIcon => text()(); // Added for history persistence
  IntColumn get snapshotValue => integer().map(const TimeValueConverter())();
  
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
