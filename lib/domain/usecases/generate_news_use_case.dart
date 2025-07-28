import 'dart:math';

import 'package:galactic_football_league/domain/models/match_result.dart';
import 'package:galactic_football_league/domain/models/news_item.dart';
import 'package:galactic_football_league/domain/repositories/match_repository.dart';
import 'package:uuid/uuid.dart';

class GenerateNewsUseCase {
  final MatchRepository repository;

  GenerateNewsUseCase(this.repository);

  Future<void> call(MatchResult result) async {
    final newsItem = _generateNewsItem(result);
    await repository.saveNewsItem(newsItem);
  }

  NewsItem _generateNewsItem(MatchResult result) {
    final random = Random();
    final templateKey =
        'newsTemplate${random.nextInt(4) + 1}'; // Generates newsTemplate1, 2, 3, or 4

    String title = result.score1 > result.score2
        ? "${result.team1.name} Triumph Over ${result.team2.name}!"
        : result.score2 > result.score1
            ? "${result.team2.name} Defeat ${result.team1.name}!"
            : "Thrilling Draw Between ${result.team1.name} and ${result.team2.name}!";

    return NewsItem(
      id: const Uuid().v4(),
      title: title,
      contentTemplateKey: templateKey,
      date: DateTime.now(),
      team1Name: result.team1.name,
      team2Name: result.team2.name,
      score1: result.score1,
      score2: result.score2,
    );
  }
}