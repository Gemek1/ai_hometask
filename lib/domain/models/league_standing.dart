import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/team.dart';

class LeagueStanding extends Equatable {
  final Team team;
  final int wins;
  final int losses;
  final int draws;
  final int points;

  const LeagueStanding({
    required this.team,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.points,
  });

  factory LeagueStanding.initial({required Team team}) {
    return LeagueStanding(
      team: team,
      wins: 0,
      losses: 0,
      draws: 0,
      points: 0,
    );
  }

  LeagueStanding copyWith({
    Team? team,
    int? wins,
    int? losses,
    int? draws,
    int? points,
  }) {
    return LeagueStanding(
      team: team ?? this.team,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      draws: draws ?? this.draws,
      points: points ?? this.points,
    );
  }

  @override
  List<Object?> get props => [team, wins, losses, draws, points];
}