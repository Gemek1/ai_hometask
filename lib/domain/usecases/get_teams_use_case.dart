import 'package:galactic_football_league/domain/models/team.dart';
import 'package:galactic_football_league/domain/repositories/team_repository.dart';

class GetTeamsUseCase {
  final TeamRepository repository;

  GetTeamsUseCase(this.repository);

  Future<List<Team>> call() async {
    return repository.getTeams();
  }
}