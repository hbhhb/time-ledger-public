import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/database/seeder.dart';
import 'package:time_ledger/core/theme/app_theme.dart';
import 'package:time_ledger/presentation/screens/main_scaffold.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger Seeder
    ref.watch(seedCategoriesProvider);
    
    // Set Status Bar Style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // Remove splash screen when UI is ready
    // Using addPostFrameCallback to ensure the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    return MaterialApp(
      title: 'Time Ledger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainScaffold(),
    );
  }
}
