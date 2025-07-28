import 'package:galactic_football_league/data/models/team_dto.dart';

class MockTeamProvider {
  Future<List<TeamDto>> getTeams() async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      TeamDto(id: '1', name: 'Mars United', planetName: 'Mars', power: 80, defense: 60, speed: 75),
      TeamDto(id: '2', name: 'Jupiter Giants', planetName: 'Jupiter', power: 95, defense: 80, speed: 50),
      TeamDto(id: '3', name: 'Saturn Rings', planetName: 'Saturn', power: 70, defense: 90, speed: 65),
      TeamDto(id: '4', name: 'Venus Vipers', planetName: 'Venus', power: 85, defense: 55, speed: 85),
      TeamDto(id: '5', name: 'Neptune Nomads', planetName: 'Neptune', power: 65, defense: 70, speed: 70),
      TeamDto(id: '6', name: 'Mercury Meteors', planetName: 'Mercury', power: 75, defense: 50, speed: 95),
    ];
  }
}