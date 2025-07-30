import 'package:galactic_football_league/domain/models/rocket_team.dart';

abstract class SpaceXRepository {
  Future<List<RocketTeam>> getRocketTeams();
  // Здесь можно добавить и другие методы, например, для истории запусков
}