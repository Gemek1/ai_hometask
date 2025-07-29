import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/presentation/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:galactic_football_league/presentation/features/match_history/match_history.dart';
import 'package:galactic_football_league/domain/domain.dart';
import 'package:galactic_football_league/presentation/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../../localization/locales.dart';

@RoutePage()
class MatchHistoryScreen extends StatelessWidget {
  const MatchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchHistoryBloc(
        getMatchHistoryUseCase: GetIt.instance<GetMatchHistoryUseCase>(),
      )..add(LoadMatchHistory()),
      child: const MatchHistoryView(),
    );
  }
}

class MatchHistoryView extends StatelessWidget {
  const MatchHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.matchHistory.getString(context)),
        actions: [
          // Кнопка смены языка
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final localization = FlutterLocalization.instance;
              if (localization.currentLocale?.languageCode == 'en') {
                localization.translate('ru');
              } else {
                localization.translate('en');
              }
            },
          ),
          // Кнопка смены темы
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: Provider.of<ThemeProvider>(context),
        builder: (context, child) => Theme(
          data: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          child: child ?? SizedBox(),
        ),
        child: BlocBuilder<MatchHistoryBloc, MatchHistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HistoryLoaded) {
              if (state.results.isEmpty) {
                return Center(
                  child: Text(
                    AppLocale.noMatchesPlayed.getString(context),
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  final result = state.results[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(result.team1.name,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "${result.score1} - ${result.score2}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Expanded(
                              child: Text(result.team2.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat.yMMMd().add_jm().format(result.date),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is HistoryError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
