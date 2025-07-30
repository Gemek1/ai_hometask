import 'package:galactic_football_league/data/models/launch_dto.dart';
import 'package:galactic_football_league/data/models/rocket_dto.dart';
import 'package:galactic_football_league/data/models/team_dto.dart';
import 'package:hive_ce/hive.dart';
import '../domain/domain.dart';

@GenerateAdapters([
  AdapterSpec<LeagueStanding>(),
  AdapterSpec<NewsItem>(),
  AdapterSpec<Team>(),
  AdapterSpec<MatchResult>(),
  AdapterSpec<TeamDto>(),
  AdapterSpec<RocketDto>(),
  AdapterSpec<LaunchDto>(),
])
part 'hive_adapters.g.dart';
