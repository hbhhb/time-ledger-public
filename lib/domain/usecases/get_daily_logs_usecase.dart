import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';

class GetDailyLogsUseCase {
  final LogRepository _logRepository;

  GetDailyLogsUseCase(this._logRepository);

  Stream<List<LogEntity>> execute(DateTime date) {
    // Normalize date to start of day if necessary (00:00:00)
    // For now passing through, assuming UI handles normalization
    return _logRepository.watchLogsByDate(date);
  }
}
