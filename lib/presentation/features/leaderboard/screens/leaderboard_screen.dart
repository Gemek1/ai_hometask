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
      // Создаем BLoC здесь, а зависимости для него берем из GetIt
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
    // ... остальной код этого виджета не меняется
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.leaderboard.getString(context)),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppLocale.refresh.getString(context),
            onPressed: () {
              context.read<LeaderboardBloc>().add(RefreshLeaderboard());
            },
          ),
        ],
      ),
      body: BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, state) {
          if (state is LeaderboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LeaderboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<LeaderboardBloc>().add(RefreshLeaderboard());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildHeader(context),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.standings.length,
                        itemBuilder: (context, index) {
                          return TeamStandingRow(standing: state.standings[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is LeaderboardError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.router.push(const MatchSimulationRoute());
        },
        label: Text(AppLocale.startNewMatch.getString(context)),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(AppLocale.team.getString(context), style: headerStyle)),
          Expanded(flex: 1, child: Text(AppLocale.w.getString(context), style: headerStyle, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(AppLocale.d.getString(context), style: headerStyle, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(AppLocale.l.getString(context), style: headerStyle, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(AppLocale.pts.getString(context), style: headerStyle, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}