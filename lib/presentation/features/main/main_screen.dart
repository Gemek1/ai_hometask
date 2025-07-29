import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/navigation/app_router.dart';

import '../../../localization/locales.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        LeaderboardRoute(),
        MatchHistoryRoute(),
        NewsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.leaderboard),
              label: AppLocale.leaderboard.getString(context),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history),
              label: AppLocale.matches.getString(context),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.article),
              label: AppLocale.news.getString(context),
            ),
          ],
        );
      },
    );
  }
}
