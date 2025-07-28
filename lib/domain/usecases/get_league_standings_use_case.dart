import 'package:galactic_football_league/domain/models/league_standing.dart';
import 'package:galactic_football_league/domain/repositories/match_repository.dart';

class GetLeagueStandingsUseCase {
  final MatchRepository repository;

  GetLeagueStandingsUseCase(this.repository);

  Future<List<LeagueStanding>> call() async {
    return repository.getLeagueStandings();
  }
}