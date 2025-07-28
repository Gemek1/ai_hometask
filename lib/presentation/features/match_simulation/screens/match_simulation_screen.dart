import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:galactic_football_league/domain/models/team.dart';
import 'package:galactic_football_league/domain/usecases/generate_news_use_case.dart';
import 'package:galactic_football_league/presentation/features/match_simulation/match_simulation.dart';
import 'package:get_it/get_it.dart';
import 'package:galactic_football_league/domain/domain.dart';
import '../../../../localization/locales.dart';

@RoutePage()
class MatchSimulationScreen extends StatelessWidget {
  const MatchSimulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchSimulationBloc(
        getTeamsUseCase: GetIt.instance<GetTeamsUseCase>(),
        simulateMatchUseCase: GetIt.instance<SimulateMatchUseCase>(),
        generateNewsUseCase: GetIt.instance<GenerateNewsUseCase>(),
      )..add(LoadTeamsForSimulation()),
      child: const MatchSimulationView(),
    );
  }
}

class MatchSimulationView extends StatelessWidget {
  // ... остальной код этого виджета не меняется
  const MatchSimulationView({super.key});

  void _showResultDialog(BuildContext context, MatchSimulationState state) {
    if (state is SimulationFinished) {
      final result = state.result;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(AppLocale.matchResult.getString(context)),
            content: Text(
              '${result.team1.name} ${result.score1} - ${result.score2} ${result.team2.name}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close dialog
                  AutoRouter.of(context).pop(); // Go back from simulation screen
                },
                child: Text(AppLocale.close.getString(context)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.matchSimulation.getString(context)),
      ),
      body: BlocConsumer<MatchSimulationBloc, MatchSimulationState>(
        listener: (context, state) {
          if (state is SimulationFinished) {
            _showResultDialog(context, state);
          }
          if (state is SimulationError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(
                  state.message == 'Please select two different teams.'
                  ? AppLocale.selectDifferentTeams.getString(context)
                  : AppLocale.anErrorOccurred.getString(context)
                )),
              );
          }
        },
        builder: (context, state) {
          if (state is SimulationInProgress) {
            return const RocketAnimationWidget();
          }
          if (state is SimulationTeamsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SimulationTeamsLoaded || state is SimulationReadyToStart) {
            final teams = (state is SimulationTeamsLoaded)
                ? state.teams
                : (state as SimulationReadyToStart).teams;
            final team1 = (state is SimulationReadyToStart) ? state.team1 : null;
            final team2 = (state is SimulationReadyToStart) ? state.team2 : null;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTeamDropdown(context, teams, team1, 1,
                      AppLocale.selectTeam1.getString(context)),
                  const SizedBox(height: 20),
                  Text(
                    'VS',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  _buildTeamDropdown(context, teams, team2, 2,
                      AppLocale.selectTeam2.getString(context)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: (team1 != null && team2 != null && team1.id != team2.id)
                        ? () => context.read<MatchSimulationBloc>().add(StartSimulation())
                        : null,
                    child: Text(AppLocale.startMatch.getString(context)),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }

  Widget _buildTeamDropdown(
      BuildContext context, List<Team> teams, Team? selectedTeam, int teamNumber, String hint) {
    return DropdownButtonFormField<Team>(
      value: selectedTeam,
      hint: Text(hint),
      isExpanded: true,
      items: teams.map((Team team) {
        return DropdownMenuItem<Team>(
          value: team,
          child: Text(team.name),
        );
      }).toList(),
      onChanged: (Team? newValue) {
        if (newValue != null) {
          if (teamNumber == 1) {
            context.read<MatchSimulationBloc>().add(SelectTeam1(newValue));
          } else {
            context.read<MatchSimulationBloc>().add(SelectTeam2(newValue));
          }
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}