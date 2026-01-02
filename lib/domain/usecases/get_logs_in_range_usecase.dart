import 'package:time_ledger/domain/entities/log_entity.dart';
import 'package:time_ledger/domain/repositories/app_repository.dart';

class GetLogsInRangeUseCase {
  final LogRepository _repository;

  GetLogsInRangeUseCase(this._repository);

  Stream<List<LogEntity>> execute(DateTime startDate, DateTime endDate) {
    return _repository.watchLogsInRange(startDate, endDate);
  }
}
