import 'package:auto_route/auto_route.dart';
import 'package:galactic_football_league/presentation/features/features.dart';

// ... импорты
import 'package:galactic_football_league/presentation/features/login/login_screen.dart';
import 'package:galactic_football_league/presentation/features/splash/splash_screen.dart';
import 'package:galactic_football_league/presentation/features/spacex/rocket_teams_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Новый начальный маршрут
        AutoRoute(page: SplashRoute.page, initial: true),
        // Экран логина
        AutoRoute(page: LoginRoute.page),
        // Основной экран с табами
        AutoRoute(
          page: MainRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'leaderboard'),
            AutoRoute(path: 'leaderboard', page: LeaderboardRoute.page),
            AutoRoute(path: 'matches', page: MatchHistoryRoute.page),
            AutoRoute(path: 'news', page: NewsRoute.page),
            // ✅ Новый таб с командами SpaceX
            AutoRoute(path: 'teams', page: RocketTeamsRoute.page),
          ],
        ),
        AutoRoute(
          path: '/simulation',
          page: MatchSimulationRoute.page,
        ),
        // Сюда можно добавить роут для экрана деталей ракеты
      ];
}