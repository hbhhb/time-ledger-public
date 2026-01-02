import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_ledger/core/theme/app_colors_legacy.dart';
import 'package:time_ledger/presentation/screens/analysis/widgets/analysis_category_list.dart';
import 'package:time_ledger/presentation/screens/analysis/widgets/analysis_header.dart';
import 'package:time_ledger/presentation/screens/analysis/widgets/analysis_summary.dart';

class AnalysisScreen extends ConsumerWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: AppColorsLegacy.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnalysisHeader(),
              AnalysisSummary(),
              AnalysisCategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
