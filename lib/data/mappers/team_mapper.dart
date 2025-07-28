import 'package:galactic_football_league/data/models/team_dto.dart';
import 'package:galactic_football_league/domain/models/team.dart';

class TeamMapper {
  Team fromDto(TeamDto dto) {
    return Team(
      id: dto.id,
      name: dto.name,
      planetName: dto.planetName,
      power: dto.power,
      defense: dto.defense,
      speed: dto.speed,
    );
  }
}