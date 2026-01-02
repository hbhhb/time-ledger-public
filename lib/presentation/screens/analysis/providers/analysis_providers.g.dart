// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weeklyLogsHash() => r'd67c8c32fa3b74e085be3f12d2e02d9b62ef4018';

/// See also [weeklyLogs].
@ProviderFor(weeklyLogs)
final weeklyLogsProvider = AutoDisposeStreamProvider<List<LogEntity>>.internal(
  weeklyLogs,
  name: r'weeklyLogsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weeklyLogsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeeklyLogsRef = AutoDisposeStreamProviderRef<List<LogEntity>>;
String _$analysisStatsHash() => r'f0da5d21b28e48fb2d8e7862780021bbb42555bd';

/// See also [analysisStats].
@ProviderFor(analysisStats)
final analysisStatsProvider = AutoDisposeFutureProvider<WeeklyStats>.internal(
  analysisStats,
  name: r'analysisStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analysisStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnalysisStatsRef = AutoDisposeFutureProviderRef<WeeklyStats>;
String _$analysisDateHash() => r'f050abb7cd087aa447c22937b8930ec20d7504ab';

/// See also [AnalysisDate].
@ProviderFor(AnalysisDate)
final analysisDateProvider =
    AutoDisposeNotifierProvider<AnalysisDate, DateTime>.internal(
  AnalysisDate.new,
  name: r'analysisDateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$analysisDateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AnalysisDate = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
