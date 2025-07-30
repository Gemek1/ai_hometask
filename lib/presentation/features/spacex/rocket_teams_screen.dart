import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/domain/usecases/get_rocket_teams_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../../localization/locales.dart';
import '../../theme/theme_provider.dart';
import 'bloc/rocket_teams_bloc.dart';
import 'bloc/rocket_teams_event.dart';
import 'bloc/rocket_teams_state.dart';

@RoutePage()
class RocketTeamsScreen extends StatelessWidget {
  const RocketTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return BlocProvider(
      create: (_) => RocketTeamsBloc(
        getRocketTeamsUseCase: GetIt.instance<GetRocketTeamsUseCase>(),
      )..add(FetchRocketTeams()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.spacexTeams.getString(context)),
          // ✅ Добавляем кнопки
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                final localization = FlutterLocalization.instance;
                localization.translate(
                    localization.currentLocale?.languageCode == 'en'
                        ? 'ru'
                        : 'en');
              },
            ),
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => themeProvider.toggleTheme(!isDarkMode),
            ),
          ],
        ),
        body: BlocBuilder<RocketTeamsBloc, RocketTeamsState>(
          builder: (context, state) {
            if (state is RocketTeamsLoading || state is RocketTeamsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RocketTeamsLoaded) {
              if (state.teams.isEmpty) {
                // ✅ Используем локализацию
                return Center(
                    child: Text(AppLocale.noDataFound.getString(context)));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<RocketTeamsBloc>().add(FetchRocketTeams());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: state.teams.length,
                  itemBuilder: (context, index) {
                    final team = state.teams[index];
                    return Card(
                      child: ListTile(
                        leading: team.photoUrl.isNotEmpty
                            ? Image.network(
                                team.photoUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.rocket, size: 40),
                              )
                            : const Icon(Icons.rocket, size: 40),
                        title: Text(team.name),
                        subtitle: Text(
                            'Сила: ${team.power}, Защита: ${team.defense}'),
                      ),
                    );
                  },
                ),
              );
            }

            if (state is RocketTeamsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  // ✅ Используем локализацию с параметром
                  child: Text(
                    AppLocale.loadingError.getString(
                      context,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
