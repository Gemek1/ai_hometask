import 'package:galactic_football_league/domain/models/rocket_team.dart';
import 'package:galactic_football_league/domain/repositories/spacex_repository.dart';

class GetRocketTeamsUseCase {
  final SpaceXRepository repository;
  GetRocketTeamsUseCase(this.repository);

  Future<List<RocketTeam>> call() => repository.getRocketTeams();
}