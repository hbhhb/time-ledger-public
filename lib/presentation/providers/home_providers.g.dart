// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasLogsHash() => r'29066f15dbcd801d06a8403721dcb5557ae39138';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [hasLogs].
@ProviderFor(hasLogs)
const hasLogsProvider = HasLogsFamily();

/// See also [hasLogs].
class HasLogsFamily extends Family<bool> {
  /// See also [hasLogs].
  const HasLogsFamily();

  /// See also [hasLogs].
  HasLogsProvider call(
    DateTime date,
  ) {
    return HasLogsProvider(
      date,
    );
  }

  @override
  HasLogsProvider getProviderOverride(
    covariant HasLogsProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasLogsProvider';
}

/// See also [hasLogs].
class HasLogsProvider extends AutoDisposeProvider<bool> {
  /// See also [hasLogs].
  HasLogsProvider(
    DateTime date,
  ) : this._internal(
          (ref) => hasLogs(
            ref as HasLogsRef,
            date,
          ),
          from: hasLogsProvider,
          name: r'hasLogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasLogsHash,
          dependencies: HasLogsFamily._dependencies,
          allTransitiveDependencies: HasLogsFamily._allTransitiveDependencies,
          date: date,
        );

  HasLogsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    bool Function(HasLogsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasLogsProvider._internal(
        (ref) => create(ref as HasLogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HasLogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasLogsProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasLogsRef on AutoDisposeProviderRef<bool> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _HasLogsProviderElement extends AutoDisposeProviderElement<bool>
    with HasLogsRef {
  _HasLogsProviderElement(super.provider);

  @override
  DateTime get date => (origin as HasLogsProvider).date;
}

String _$logListRangeHash() => r'b91843a2734d7e554d77ac5576855cd87a85e7cb';

/// See also [logListRange].
@ProviderFor(logListRange)
final logListRangeProvider =
    AutoDisposeStreamProvider<List<LogEntity>>.internal(
  logListRange,
  name: r'logListRangeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logListRangeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LogListRangeRef = AutoDisposeStreamProviderRef<List<LogEntity>>;
String _$hasLogsInPreviousMonthHash() =>
    r'3aed89c69a936126e377fe275c221e5ba91cf6f4';

/// See also [hasLogsInPreviousMonth].
@ProviderFor(hasLogsInPreviousMonth)
final hasLogsInPreviousMonthProvider = AutoDisposeProvider<bool>.internal(
  hasLogsInPreviousMonth,
  name: r'hasLogsInPreviousMonthProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasLogsInPreviousMonthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasLogsInPreviousMonthRef = AutoDisposeProviderRef<bool>;
String _$groupedLogsHash() => r'2c3063ae6a9ad9542677d713e752472671227fc0';

/// See also [groupedLogs].
@ProviderFor(groupedLogs)
final groupedLogsProvider =
    AutoDisposeProvider<Map<DateTime, List<LogEntity>>>.internal(
  groupedLogs,
  name: r'groupedLogsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$groupedLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GroupedLogsRef = AutoDisposeProviderRef<Map<DateTime, List<LogEntity>>>;
String _$sortedDatesHash() => r'9fb880a7296ac722b2e9b718e4e75755005fb134';

/// See also [sortedDates].
@ProviderFor(sortedDates)
final sortedDatesProvider = AutoDisposeProvider<List<DateTime>>.internal(
  sortedDates,
  name: r'sortedDatesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortedDatesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SortedDatesRef = AutoDisposeProviderRef<List<DateTime>>;
String _$grassLevelsHash() => r'687c2586a7b1a42fd0b00aa2f202502d819123cf';

/// See also [grassLevels].
@ProviderFor(grassLevels)
final grassLevelsProvider = AutoDisposeProvider<Map<DateTime, int>>.internal(
  grassLevels,
  name: r'grassLevelsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$grassLevelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GrassLevelsRef = AutoDisposeProviderRef<Map<DateTime, int>>;
String _$selectedDateHash() => r'11327f649ac540922b8258d49cabd17b4de5dfe5';

/// See also [SelectedDate].
@ProviderFor(SelectedDate)
final selectedDateProvider =
    AutoDisposeNotifierProvider<SelectedDate, DateTime?>.internal(
  SelectedDate.new,
  name: r'selectedDateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedDate = AutoDisposeNotifier<DateTime?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
