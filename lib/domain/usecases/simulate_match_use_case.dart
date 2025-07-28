import 'dart:math';

import 'package:galactic_football_league/domain/models/match_result.dart';
import 'package:galactic_football_league/domain/models/team.dart';
import 'package:galactic_football_league/domain/repositories/match_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

class SimulateMatchUseCase {
  final MatchRepository repository;
  final Random _random = Random();

  SimulateMatchUseCase(this.repository);

  Future<MatchResult> call(Team teamA, Team teamB) async {
    int scoreA = 0;
    int scoreB = 0;
    const int numAttacks = 10;

    // Calculate chance to score for each team
    double chanceToScoreA = (teamA.power - teamB.defense) + (teamA.speed * 0.5);
    double chanceToScoreB = (teamB.power - teamA.defense) + (teamB.speed * 0.5);

    // Default to 1 if negative
    if (chanceToScoreA < 1) chanceToScoreA = 1;
    if (chanceToScoreB < 1) chanceToScoreB = 1;
    
    // Simulate attacks for Team A
    for (int i = 0; i < numAttacks; i++) {
      if (_random.nextInt(100) < chanceToScoreA) {
        scoreA++;
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50);
        }
      }
    }

    // Simulate attacks for Team B
    for (int i = 0; i < numAttacks; i++) {
      if (_random.nextInt(100) < chanceToScoreB) {
        scoreB++;
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50);
        }
      }
    }

    final result = MatchResult(
      id: const Uuid().v4(),
      team1: teamA,
      team2: teamB,
      score1: scoreA,
      score2: scoreB,
      date: DateTime.now(),
    );

    await repository.saveMatchResult(result);
    return result;
  }
}