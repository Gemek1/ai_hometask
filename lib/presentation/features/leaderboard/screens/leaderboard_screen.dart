import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/domain/domain.dart';
import 'package:galactic_football_league/navigation/app_router.dart';
import 'package:galactic_football_league/presentation/features/leaderboard/leaderboard.dart';
import 'package:galactic_football_league/presentation/theme/theme_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../../../localization/locales.dart';

@RoutePage()
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaderboardBloc(
        getLeagueStandingsUseCase: GetIt.instance<GetLeagueStandingsUseCase>(),
      )..add(LoadLeaderboard()),
      child: const LeaderboardView(),
    );
  }
}

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      extendBodyBehindAppBar: isDarkMode,
      appBar: AppBar(
        title: Text(AppLocale.leaderboard.getString(context)),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final localization = FlutterLocalization.instance;
              localization.translate(
                  localization.currentLocale?.languageCode == 'en' ? 'ru' : 'en');
            },
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(!isDarkMode),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppLocale.refresh.getString(context),
            onPressed: () =>
                context.read<LeaderboardBloc>().add(RefreshLeaderboard()),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (isDarkMode)
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.0,
                  colors: [
                    Color(0x4400FFFF),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          // ✅ Оборачиваем BlocBuilder в SafeArea
          SafeArea(
            // Отключаем отступ снизу, чтобы FAB не мешал
            bottom: false,
            child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
              builder: (context, state) {
                if (state is LeaderboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LeaderboardLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async => context
                        .read<LeaderboardBloc>()
                        .add(RefreshLeaderboard()),
                    child: ListView.separated(
                      // Убираем верхний отступ, т.к. SafeArea его обеспечивает
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                      itemCount: state.standings.length,
                      itemBuilder: (context, index) {
                        return TeamStandingRow(
                          rank: index + 1,
                          standing: state.standings[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                  );
                }
                if (state is LeaderboardError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Something went wrong.'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.push(const MatchSimulationRoute()),
        label: Text(AppLocale.startNewMatch.getString(context)),
        icon: const Icon(Icons.add),
      ),
    );
  }
}