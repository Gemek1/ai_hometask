import 'package:galactic_football_league/data/data.dart';
import 'package:galactic_football_league/data/datasources/spacex_provider.dart';
import 'package:galactic_football_league/data/models/rocket_dto.dart';
import 'package:galactic_football_league/data/repositories/spacex_repository_impl.dart';
import 'package:galactic_football_league/domain/domain.dart';
import 'package:galactic_football_league/domain/repositories/spacex_repository.dart';
import 'package:galactic_football_league/domain/usecases/get_rocket_teams_use_case.dart';
import 'package:galactic_football_league/hive/hive_registrar.g.dart';
import 'package:galactic_football_league/navigation/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../domain/usecases/generate_news_use_case.dart';
import '../core.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  await Hive.initFlutter();
  Hive.registerAdapters();

  // Hive Boxes
  final Box<RocketDto> rocketBox =
      await Hive.openBox<RocketDto>(AppConstants.rocketsBox);
  final Box<TeamDto> teamsBox =
      await Hive.openBox<TeamDto>(AppConstants.teamsBox);
  final Box<MatchResult> matchesBox =
      await Hive.openBox<MatchResult>(AppConstants.matchesBox);
  final Box<LeagueStanding> standingsBox =
      await Hive.openBox<LeagueStanding>(AppConstants.standingsBox);
  final Box<NewsItem> newsBox =
      await Hive.openBox<NewsItem>(AppConstants.newsBox);

  getIt.registerSingleton<Box<RocketDto>>(rocketBox);
  getIt.registerSingleton<Box<TeamDto>>(teamsBox);
  getIt.registerSingleton<Box<MatchResult>>(matchesBox);
  getIt.registerSingleton<Box<LeagueStanding>>(standingsBox);
  getIt.registerSingleton<Box<NewsItem>>(newsBox);

  // Use Cases
  getIt.registerLazySingleton(() => GetTeamsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLeagueStandingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMatchHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => SimulateMatchUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNewsUseCase(getIt()));
  getIt.registerLazySingleton(() => GenerateNewsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRocketTeamsUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<TeamRepository>(() => TeamRepositoryImpl(
        mockTeamProvider: getIt(),
        teamMapper: getIt(),
        teamBox: getIt(),
      ));
  getIt.registerLazySingleton<MatchRepository>(() => MatchRepositoryImpl(
        standingsBox: getIt(),
        matchesBox: getIt(),
        newsBox: getIt(),
      ));
  getIt.registerLazySingleton<SpaceXRepository>(
      () => SpaceXRepositoryImpl(provider: getIt(), rocketBox: getIt()));

  // Data Sources & Mappers
  getIt.registerLazySingleton(() => SpaceXProvider());
  getIt.registerLazySingleton(() => MockTeamProvider());
  getIt.registerLazySingleton(() => TeamMapper());
}
