import 'package:galactic_football_league/data/models/team_dto.dart';
import 'package:hive_ce/hive.dart';
import '../domain/domain.dart';

@GenerateAdapters([
  AdapterSpec<LeagueStanding>(),
  AdapterSpec<NewsItem>(),
  AdapterSpec<Team>(),
  AdapterSpec<MatchResult>(),
  AdapterSpec<TeamDto>(),
])
part 'hive_adapters.g.dart';
