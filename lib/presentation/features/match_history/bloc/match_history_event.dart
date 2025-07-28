import 'package:equatable/equatable.dart';

abstract class MatchHistoryEvent extends Equatable {
  const MatchHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadMatchHistory extends MatchHistoryEvent {}