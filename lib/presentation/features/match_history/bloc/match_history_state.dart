import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/match_result.dart';

abstract class MatchHistoryState extends Equatable {
  const MatchHistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends MatchHistoryState {}

class HistoryLoading extends MatchHistoryState {}

class HistoryLoaded extends MatchHistoryState {
  final List<MatchResult> results;

  const HistoryLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class HistoryError extends MatchHistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}