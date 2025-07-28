import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/league_standing.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeagueStanding> standings;

  const LeaderboardLoaded(this.standings);

  @override
  List<Object> get props => [standings];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);

  @override
  List<Object> get props => [message];
}