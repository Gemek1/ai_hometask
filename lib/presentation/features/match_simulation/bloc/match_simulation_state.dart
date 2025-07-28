import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/match_result.dart';
import 'package:galactic_football_league/domain/models/team.dart';

abstract class MatchSimulationState extends Equatable {
  const MatchSimulationState();

  @override
  List<Object?> get props => [];
}

class SimulationInitial extends MatchSimulationState {}

class SimulationTeamsLoading extends MatchSimulationState {}

class SimulationTeamsLoaded extends MatchSimulationState {
  final List<Team> teams;
  
  const SimulationTeamsLoaded({required this.teams});

  @override
  List<Object?> get props => [teams];
}

class SimulationReadyToStart extends MatchSimulationState {
  final List<Team> teams;
  final Team? team1;
  final Team? team2;

  const SimulationReadyToStart({required this.teams, this.team1, this.team2});

  @override
  List<Object?> get props => [teams, team1, team2];
}

class SimulationInProgress extends MatchSimulationState {}

class SimulationFinished extends MatchSimulationState {
  final MatchResult result;

  const SimulationFinished(this.result);

  @override
  List<Object> get props => [result];
}

class SimulationError extends MatchSimulationState {
  final String message;

  const SimulationError(this.message);

  @override
  List<Object> get props => [message];
}