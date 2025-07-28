import 'package:galactic_football_league/domain/models/team.dart';

abstract class TeamRepository {
  Future<List<Team>> getTeams();
}