import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/team.dart';

abstract class MatchSimulationEvent extends Equatable {
  const MatchSimulationEvent();
}

class LoadTeamsForSimulation extends MatchSimulationEvent {
  @override
  List<Object> get props => [];
}

class SelectTeam1 extends MatchSimulationEvent {
  final Team team;
  const SelectTeam1(this.team);
  @override
  List<Object> get props => [team];
}

class SelectTeam2 extends MatchSimulationEvent {
  final Team team;
  const SelectTeam2(this.team);
  @override
  List<Object> get props => [team];
}

class StartSimulation extends MatchSimulationEvent {
  @override
  List<Object> get props => [];
}