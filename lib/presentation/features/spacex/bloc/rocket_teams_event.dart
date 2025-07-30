import 'package:equatable/equatable.dart';

abstract class RocketTeamsEvent extends Equatable {
  const RocketTeamsEvent();
  @override
  List<Object> get props => [];
}

// Событие для запроса данных
class FetchRocketTeams extends RocketTeamsEvent {}