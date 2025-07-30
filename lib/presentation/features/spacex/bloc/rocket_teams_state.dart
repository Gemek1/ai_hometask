import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/rocket_team.dart';

abstract class RocketTeamsState extends Equatable {
  const RocketTeamsState();
  @override
  List<Object> get props => [];
}

// Начальное состояние
class RocketTeamsInitial extends RocketTeamsState {}

// Состояние загрузки
class RocketTeamsLoading extends RocketTeamsState {}

// Состояние, когда данные успешно загружены
class RocketTeamsLoaded extends RocketTeamsState {
  final List<RocketTeam> teams;
  const RocketTeamsLoaded(this.teams);
  @override
  List<Object> get props => [teams];
}

// Состояние ошибки
class RocketTeamsError extends RocketTeamsState {
  final String message;
  const RocketTeamsError(this.message);
  @override
  List<Object> get props => [message];
}