import 'package:galactic_football_league/domain/models/league_standing.dart';
import 'package:galactic_football_league/domain/models/match_result.dart';

import '../models/news_item.dart';

abstract class MatchRepository {
  Future<void> saveMatchResult(MatchResult result);
  Future<List<MatchResult>> getMatchHistory();
  Future<List<LeagueStanding>> getLeagueStandings();
  Future<void> saveNewsItem(NewsItem newsItem);
  Future<List<NewsItem>> getNews();
}