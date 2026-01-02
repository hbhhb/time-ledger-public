// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TimeValue, int> defaultValue =
      GeneratedColumn<int>('default_value', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TimeValue>($CategoriesTable.$converterdefaultValue);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, icon, defaultValue, isActive, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      defaultValue: $CategoriesTable.$converterdefaultValue.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}default_value'])!),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeValue, int> $converterdefaultValue =
      const TimeValueConverter();
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String icon;
  final TimeValue defaultValue;
  final bool isActive;
  final int sortOrder;
  const Category(
      {required this.id,
      required this.name,
      required this.icon,
      required this.defaultValue,
      required this.isActive,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    {
      map['default_value'] = Variable<int>(
          $CategoriesTable.$converterdefaultValue.toSql(defaultValue));
    }
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      defaultValue: Value(defaultValue),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      defaultValue: serializer.fromJson<TimeValue>(json['defaultValue']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'defaultValue': serializer.toJson<TimeValue>(defaultValue),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith(
          {String? id,
          String? name,
          String? icon,
          TimeValue? defaultValue,
          bool? isActive,
          int? sortOrder}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        defaultValue: defaultValue ?? this.defaultValue,
        isActive: isActive ?? this.isActive,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      defaultValue: data.defaultValue.present
          ? data.defaultValue.value
          : this.defaultValue,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, icon, defaultValue, isActive, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.defaultValue == this.defaultValue &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<TimeValue> defaultValue;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.defaultValue = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String icon,
    required TimeValue defaultValue,
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        icon = Value(icon),
        defaultValue = Value(defaultValue);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? defaultValue,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (defaultValue != null) 'default_value': defaultValue,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? icon,
      Value<TimeValue>? defaultValue,
      Value<bool>? isActive,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      defaultValue: defaultValue ?? this.defaultValue,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (defaultValue.present) {
      map['default_value'] = Variable<int>(
          $CategoriesTable.$converterdefaultValue.toSql(defaultValue.value));
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('defaultValue: $defaultValue, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogsTable extends Logs with TableInfo<$LogsTable, Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _snapshotNameMeta =
      const VerificationMeta('snapshotName');
  @override
  late final GeneratedColumn<String> snapshotName = GeneratedColumn<String>(
      'snapshot_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _snapshotIconMeta =
      const VerificationMeta('snapshotIcon');
  @override
  late final GeneratedColumn<String> snapshotIcon = GeneratedColumn<String>(
      'snapshot_icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TimeValue, int> snapshotValue =
      GeneratedColumn<int>('snapshot_value', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TimeValue>($LogsTable.$convertersnapshotValue);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        targetDate,
        categoryId,
        duration,
        snapshotName,
        snapshotIcon,
        snapshotValue,
        memo,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs';
  @override
  VerificationContext validateIntegrity(Insertable<Log> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    } else if (isInserting) {
      context.missing(_targetDateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('snapshot_name')) {
      context.handle(
          _snapshotNameMeta,
          snapshotName.isAcceptableOrUnknown(
              data['snapshot_name']!, _snapshotNameMeta));
    } else if (isInserting) {
      context.missing(_snapshotNameMeta);
    }
    if (data.containsKey('snapshot_icon')) {
      context.handle(
          _snapshotIconMeta,
          snapshotIcon.isAcceptableOrUnknown(
              data['snapshot_icon']!, _snapshotIconMeta));
    } else if (isInserting) {
      context.missing(_snapshotIconMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Log(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      snapshotName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snapshot_name'])!,
      snapshotIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snapshot_icon'])!,
      snapshotValue: $LogsTable.$convertersnapshotValue.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snapshot_value'])!),
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LogsTable createAlias(String alias) {
    return $LogsTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeValue, int> $convertersnapshotValue =
      const TimeValueConverter();
}

class Log extends DataClass implements Insertable<Log> {
  final String id;
  final DateTime targetDate;
  final String? categoryId;
  final int duration;
  final String snapshotName;
  final String snapshotIcon;
  final TimeValue snapshotValue;
  final String? memo;
  final DateTime createdAt;
  const Log(
      {required this.id,
      required this.targetDate,
      this.categoryId,
      required this.duration,
      required this.snapshotName,
      required this.snapshotIcon,
      required this.snapshotValue,
      this.memo,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['target_date'] = Variable<DateTime>(targetDate);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['duration'] = Variable<int>(duration);
    map['snapshot_name'] = Variable<String>(snapshotName);
    map['snapshot_icon'] = Variable<String>(snapshotIcon);
    {
      map['snapshot_value'] = Variable<int>(
          $LogsTable.$convertersnapshotValue.toSql(snapshotValue));
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LogsCompanion toCompanion(bool nullToAbsent) {
    return LogsCompanion(
      id: Value(id),
      targetDate: Value(targetDate),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      duration: Value(duration),
      snapshotName: Value(snapshotName),
      snapshotIcon: Value(snapshotIcon),
      snapshotValue: Value(snapshotValue),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
    );
  }

  factory Log.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Log(
      id: serializer.fromJson<String>(json['id']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      duration: serializer.fromJson<int>(json['duration']),
      snapshotName: serializer.fromJson<String>(json['snapshotName']),
      snapshotIcon: serializer.fromJson<String>(json['snapshotIcon']),
      snapshotValue: serializer.fromJson<TimeValue>(json['snapshotValue']),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'categoryId': serializer.toJson<String?>(categoryId),
      'duration': serializer.toJson<int>(duration),
      'snapshotName': serializer.toJson<String>(snapshotName),
      'snapshotIcon': serializer.toJson<String>(snapshotIcon),
      'snapshotValue': serializer.toJson<TimeValue>(snapshotValue),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Log copyWith(
          {String? id,
          DateTime? targetDate,
          Value<String?> categoryId = const Value.absent(),
          int? duration,
          String? snapshotName,
          String? snapshotIcon,
          TimeValue? snapshotValue,
          Value<String?> memo = const Value.absent(),
          DateTime? createdAt}) =>
      Log(
        id: id ?? this.id,
        targetDate: targetDate ?? this.targetDate,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        duration: duration ?? this.duration,
        snapshotName: snapshotName ?? this.snapshotName,
        snapshotIcon: snapshotIcon ?? this.snapshotIcon,
        snapshotValue: snapshotValue ?? this.snapshotValue,
        memo: memo.present ? memo.value : this.memo,
        createdAt: createdAt ?? this.createdAt,
      );
  Log copyWithCompanion(LogsCompanion data) {
    return Log(
      id: data.id.present ? data.id.value : this.id,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      duration: data.duration.present ? data.duration.value : this.duration,
      snapshotName: data.snapshotName.present
          ? data.snapshotName.value
          : this.snapshotName,
      snapshotIcon: data.snapshotIcon.present
          ? data.snapshotIcon.value
          : this.snapshotIcon,
      snapshotValue: data.snapshotValue.present
          ? data.snapshotValue.value
          : this.snapshotValue,
      memo: data.memo.present ? data.memo.value : this.memo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Log(')
          ..write('id: $id, ')
          ..write('targetDate: $targetDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('duration: $duration, ')
          ..write('snapshotName: $snapshotName, ')
          ..write('snapshotIcon: $snapshotIcon, ')
          ..write('snapshotValue: $snapshotValue, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, targetDate, categoryId, duration,
      snapshotName, snapshotIcon, snapshotValue, memo, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Log &&
          other.id == this.id &&
          other.targetDate == this.targetDate &&
          other.categoryId == this.categoryId &&
          other.duration == this.duration &&
          other.snapshotName == this.snapshotName &&
          other.snapshotIcon == this.snapshotIcon &&
          other.snapshotValue == this.snapshotValue &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt);
}

class LogsCompanion extends UpdateCompanion<Log> {
  final Value<String> id;
  final Value<DateTime> targetDate;
  final Value<String?> categoryId;
  final Value<int> duration;
  final Value<String> snapshotName;
  final Value<String> snapshotIcon;
  final Value<TimeValue> snapshotValue;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LogsCompanion({
    this.id = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.duration = const Value.absent(),
    this.snapshotName = const Value.absent(),
    this.snapshotIcon = const Value.absent(),
    this.snapshotValue = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogsCompanion.insert({
    required String id,
    required DateTime targetDate,
    this.categoryId = const Value.absent(),
    required int duration,
    required String snapshotName,
    required String snapshotIcon,
    required TimeValue snapshotValue,
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        targetDate = Value(targetDate),
        duration = Value(duration),
        snapshotName = Value(snapshotName),
        snapshotIcon = Value(snapshotIcon),
        snapshotValue = Value(snapshotValue);
  static Insertable<Log> custom({
    Expression<String>? id,
    Expression<DateTime>? targetDate,
    Expression<String>? categoryId,
    Expression<int>? duration,
    Expression<String>? snapshotName,
    Expression<String>? snapshotIcon,
    Expression<int>? snapshotValue,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetDate != null) 'target_date': targetDate,
      if (categoryId != null) 'category_id': categoryId,
      if (duration != null) 'duration': duration,
      if (snapshotName != null) 'snapshot_name': snapshotName,
      if (snapshotIcon != null) 'snapshot_icon': snapshotIcon,
      if (snapshotValue != null) 'snapshot_value': snapshotValue,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? targetDate,
      Value<String?>? categoryId,
      Value<int>? duration,
      Value<String>? snapshotName,
      Value<String>? snapshotIcon,
      Value<TimeValue>? snapshotValue,
      Value<String?>? memo,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LogsCompanion(
      id: id ?? this.id,
      targetDate: targetDate ?? this.targetDate,
      categoryId: categoryId ?? this.categoryId,
      duration: duration ?? this.duration,
      snapshotName: snapshotName ?? this.snapshotName,
      snapshotIcon: snapshotIcon ?? this.snapshotIcon,
      snapshotValue: snapshotValue ?? this.snapshotValue,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (snapshotName.present) {
      map['snapshot_name'] = Variable<String>(snapshotName.value);
    }
    if (snapshotIcon.present) {
      map['snapshot_icon'] = Variable<String>(snapshotIcon.value);
    }
    if (snapshotValue.present) {
      map['snapshot_value'] = Variable<int>(
          $LogsTable.$convertersnapshotValue.toSql(snapshotValue.value));
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsCompanion(')
          ..write('id: $id, ')
          ..write('targetDate: $targetDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('duration: $duration, ')
          ..write('snapshotName: $snapshotName, ')
          ..write('snapshotIcon: $snapshotIcon, ')
          ..write('snapshotValue: $snapshotValue, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $LogsTable logs = $LogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categories, logs];
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required String icon,
  required TimeValue defaultValue,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> icon,
  Value<TimeValue> defaultValue,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LogsTable, List<Log>> _logsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.logs,
          aliasName:
              $_aliasNameGenerator(db.categories.id, db.logs.categoryId));

  $$LogsTableProcessedTableManager get logsRefs {
    final manager = $$LogsTableTableManager($_db, $_db.logs)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_logsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeValue, TimeValue, int> get defaultValue =>
      $composableBuilder(
          column: $table.defaultValue,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> logsRefs(
      Expression<bool> Function($$LogsTableFilterComposer f) f) {
    final $$LogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableFilterComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultValue => $composableBuilder(
      column: $table.defaultValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeValue, int> get defaultValue =>
      $composableBuilder(
          column: $table.defaultValue, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> logsRefs<T extends Object>(
      Expression<T> Function($$LogsTableAnnotationComposer a) f) {
    final $$LogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.logs,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LogsTableAnnotationComposer(
              $db: $db,
              $table: $db.logs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool logsRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<TimeValue> defaultValue = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            icon: icon,
            defaultValue: defaultValue,
            isActive: isActive,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String icon,
            required TimeValue defaultValue,
            Value<bool> isActive = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            defaultValue: defaultValue,
            isActive: isActive,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({logsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (logsRefs) db.logs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (logsRefs)
                    await $_getPrefetchedData<Category, $CategoriesTable, Log>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriesTableReferences._logsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0).logsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (Category, $$CategoriesTableReferences),
    Category,
    PrefetchHooks Function({bool logsRefs})>;
typedef $$LogsTableCreateCompanionBuilder = LogsCompanion Function({
  required String id,
  required DateTime targetDate,
  Value<String?> categoryId,
  required int duration,
  required String snapshotName,
  required String snapshotIcon,
  required TimeValue snapshotValue,
  Value<String?> memo,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LogsTableUpdateCompanionBuilder = LogsCompanion Function({
  Value<String> id,
  Value<DateTime> targetDate,
  Value<String?> categoryId,
  Value<int> duration,
  Value<String> snapshotName,
  Value<String> snapshotIcon,
  Value<TimeValue> snapshotValue,
  Value<String?> memo,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LogsTableReferences
    extends BaseReferences<_$AppDatabase, $LogsTable, Log> {
  $$LogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias($_aliasNameGenerator(db.logs.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LogsTableFilterComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get snapshotIcon => $composableBuilder(
      column: $table.snapshotIcon, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeValue, TimeValue, int> get snapshotValue =>
      $composableBuilder(
          column: $table.snapshotValue,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableOrderingComposer extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get snapshotIcon => $composableBuilder(
      column: $table.snapshotIcon,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snapshotValue => $composableBuilder(
      column: $table.snapshotValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTable> {
  $$LogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get snapshotName => $composableBuilder(
      column: $table.snapshotName, builder: (column) => column);

  GeneratedColumn<String> get snapshotIcon => $composableBuilder(
      column: $table.snapshotIcon, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeValue, int> get snapshotValue =>
      $composableBuilder(
          column: $table.snapshotValue, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool categoryId})> {
  $$LogsTableTableManager(_$AppDatabase db, $LogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> targetDate = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<String> snapshotName = const Value.absent(),
            Value<String> snapshotIcon = const Value.absent(),
            Value<TimeValue> snapshotValue = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LogsCompanion(
            id: id,
            targetDate: targetDate,
            categoryId: categoryId,
            duration: duration,
            snapshotName: snapshotName,
            snapshotIcon: snapshotIcon,
            snapshotValue: snapshotValue,
            memo: memo,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime targetDate,
            Value<String?> categoryId = const Value.absent(),
            required int duration,
            required String snapshotName,
            required String snapshotIcon,
            required TimeValue snapshotValue,
            Value<String?> memo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LogsCompanion.insert(
            id: id,
            targetDate: targetDate,
            categoryId: categoryId,
            duration: duration,
            snapshotName: snapshotName,
            snapshotIcon: snapshotIcon,
            snapshotValue: snapshotValue,
            memo: memo,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$LogsTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$LogsTableReferences._categoryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LogsTable,
    Log,
    $$LogsTableFilterComposer,
    $$LogsTableOrderingComposer,
    $$LogsTableAnnotationComposer,
    $$LogsTableCreateCompanionBuilder,
    $$LogsTableUpdateCompanionBuilder,
    (Log, $$LogsTableReferences),
    Log,
    PrefetchHooks Function({bool categoryId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$LogsTableTableManager get logs => $$LogsTableTableManager(_db, _db.logs);
}
