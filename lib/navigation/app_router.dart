import 'package:auto_route/auto_route.dart';
import 'package:galactic_football_league/presentation/features/features.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            RedirectRoute(path: '', redirectTo: 'leaderboard'),
            AutoRoute(path: 'leaderboard', page: LeaderboardRoute.page),
            AutoRoute(path: 'matches', page: MatchHistoryRoute.page),
            AutoRoute(path: 'news', page: NewsRoute.page),
          ],
        ),
        AutoRoute(
          path: '/simulation',
          page: MatchSimulationRoute.page,
        ),
      ];
}