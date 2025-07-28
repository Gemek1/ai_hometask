import 'package:galactic_football_league/domain/models/match_result.dart';
import 'package:galactic_football_league/domain/repositories/match_repository.dart';

class GetMatchHistoryUseCase {
  final MatchRepository repository;

  GetMatchHistoryUseCase(this.repository);

  Future<List<MatchResult>> call() async {
    return repository.getMatchHistory();
  }
}