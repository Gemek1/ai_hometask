import 'package:galactic_football_league/data/datasources/mock_team_provider.dart';
import 'package:galactic_football_league/data/mappers/team_mapper.dart';
import 'package:galactic_football_league/data/models/team_dto.dart';
import 'package:galactic_football_league/domain/models/team.dart';
import 'package:galactic_football_league/domain/repositories/team_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import '../../core/constants/app_constants.dart';

class TeamRepositoryImpl implements TeamRepository {
  final MockTeamProvider mockTeamProvider;
  final TeamMapper teamMapper;
  final Box<TeamDto> teamBox;

  TeamRepositoryImpl({
    required this.mockTeamProvider,
    required this.teamMapper,
    required this.teamBox,
  });

   factory TeamRepositoryImpl.create() {
    return TeamRepositoryImpl(
      mockTeamProvider: GetIt.I.get<MockTeamProvider>(),
      teamMapper: GetIt.I.get<TeamMapper>(),
      teamBox: GetIt.I.get<Box<TeamDto>>(instanceName: AppConstants.teamsBox),
    );
  }

  @override
  Future<List<Team>> getTeams() async {
    // Try to get teams from cache first
    if (teamBox.isNotEmpty) {
      final cachedDtos = teamBox.values.toList();
      return cachedDtos.map(teamMapper.fromDto).toList();
    }

    // If cache is empty, fetch from mock provider
    final teamDtos = await mockTeamProvider.getTeams();

    // Save to cache for future requests
    await teamBox.clear(); // Clear old data before adding new
    final Map<String, TeamDto> teamMap = {for (var dto in teamDtos) dto.id: dto};
    await teamBox.putAll(teamMap);

    return teamDtos.map(teamMapper.fromDto).toList();
  }
}