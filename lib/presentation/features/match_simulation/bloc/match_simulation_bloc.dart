import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_football_league/domain/usecases/generate_news_use_case.dart';
import 'package:galactic_football_league/domain/usecases/get_teams_use_case.dart';
import 'package:galactic_football_league/domain/usecases/simulate_match_use_case.dart';
import 'package:galactic_football_league/presentation/features/match_simulation/bloc/match_simulation_event.dart';
import 'package:galactic_football_league/presentation/features/match_simulation/bloc/match_simulation_state.dart';

import '../../../../domain/domain.dart';

class MatchSimulationBloc extends Bloc<MatchSimulationEvent, MatchSimulationState> {
  final GetTeamsUseCase getTeamsUseCase;
  final SimulateMatchUseCase simulateMatchUseCase;
  final GenerateNewsUseCase generateNewsUseCase;

  MatchSimulationBloc({
    required this.getTeamsUseCase,
    required this.simulateMatchUseCase,
    required this.generateNewsUseCase,
  }) : super(SimulationInitial()) {
    on<LoadTeamsForSimulation>(_onLoadTeams);
    on<SelectTeam1>(_onSelectTeam1);
    on<SelectTeam2>(_onSelectTeam2);
    on<StartSimulation>(_onStartSimulation);
  }

  Future<void> _onLoadTeams(
      LoadTeamsForSimulation event, Emitter<MatchSimulationState> emit) async {
    emit(SimulationTeamsLoading());
    try {
      final teams = await getTeamsUseCase();
      emit(SimulationTeamsLoaded(teams: teams));
    } catch (e) {
      emit(SimulationError(e.toString()));
    }
  }

  void _onSelectTeam1(SelectTeam1 event, Emitter<MatchSimulationState> emit) {
    if (state is SimulationTeamsLoaded || state is SimulationReadyToStart) {
      final currentState = state;
      List<Team> teams = [];
      Team? team2;

      if (currentState is SimulationTeamsLoaded) {
        teams = currentState.teams;
      } else if (currentState is SimulationReadyToStart) {
        teams = currentState.teams;
        team2 = currentState.team2;
      }

      emit(SimulationReadyToStart(teams: teams, team1: event.team, team2: team2));
    }
  }

  void _onSelectTeam2(SelectTeam2 event, Emitter<MatchSimulationState> emit) {
     if (state is SimulationTeamsLoaded || state is SimulationReadyToStart) {
      final currentState = state;
      List<Team> teams = [];
      Team? team1;

      if (currentState is SimulationTeamsLoaded) {
        teams = currentState.teams;
      } else if (currentState is SimulationReadyToStart) {
        teams = currentState.teams;
        team1 = currentState.team1;
      }

      emit(SimulationReadyToStart(teams: teams, team1: team1, team2: event.team));
    }
  }

  Future<void> _onStartSimulation(
      StartSimulation event, Emitter<MatchSimulationState> emit) async {
    if (state is SimulationReadyToStart) {
      final s = state as SimulationReadyToStart;
      if (s.team1 != null && s.team2 != null && s.team1!.id != s.team2!.id) {
        emit(SimulationInProgress());
        await Future.delayed(const Duration(seconds: 3)); // For animation
        final result = await simulateMatchUseCase(s.team1!, s.team2!);
        await generateNewsUseCase(result);
        emit(SimulationFinished(result));
      } else {
        emit(SimulationError('Please select two different teams.'));
        // Re-emit previous state after error
        await Future.delayed(const Duration(seconds: 2));
        emit(s);
      }
    }
  }
}