import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/team.dart';

class MatchResult extends Equatable {
  final String id;
  final Team team1;
  final Team team2;
  final int score1;
  final int score2;
  final DateTime date;

  const MatchResult({
    required this.id,
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.date,
  });

  @override
  List<Object?> get props => [id, team1, team2, score1, score2, date];
}