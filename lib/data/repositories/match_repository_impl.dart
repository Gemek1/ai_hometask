import 'package:galactic_football_league/domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';

import '../../core/constants/app_constants.dart';

class MatchRepositoryImpl implements MatchRepository {
  final Box<LeagueStanding> standingsBox;
  final Box<MatchResult> matchesBox;
  final Box<NewsItem> newsBox;

  MatchRepositoryImpl({
    required this.standingsBox,
    required this.matchesBox,
    required this.newsBox,
  }) {
    // This constructor is intentionally left empty.
  }

  factory MatchRepositoryImpl.create() {
    return MatchRepositoryImpl(
      standingsBox: GetIt.I.get<Box<LeagueStanding>>(instanceName: AppConstants.standingsBox),
      matchesBox: GetIt.I.get<Box<MatchResult>>(instanceName: AppConstants.matchesBox),
      newsBox: GetIt.I.get<Box<NewsItem>>(instanceName: AppConstants.newsBox),
    );
  }

  @override
  Future<List<MatchResult>> getMatchHistory() async {
    return matchesBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<void> saveMatchResult(MatchResult result) async {
    await matchesBox.put(result.id, result);
    await _updateLeagueStandings(result);
  }

  Future<void> _updateLeagueStandings(MatchResult result) async {
    final standings = await getLeagueStandings();
    
    // Find or create standings for both teams
    LeagueStanding standing1 = standings.firstWhere(
      (s) => s.team.id == result.team1.id,
      orElse: () => LeagueStanding.initial(team: result.team1),
    );
    LeagueStanding standing2 = standings.firstWhere(
      (s) => s.team.id == result.team2.id,
      orElse: () => LeagueStanding.initial(team: result.team2),
    );

    // Update stats based on result
    if (result.score1 > result.score2) { // Team 1 wins
      standing1 = standing1.copyWith(wins: standing1.wins + 1, points: standing1.points + 3);
      standing2 = standing2.copyWith(losses: standing2.losses + 1);
    } else if (result.score2 > result.score1) { // Team 2 wins
      standing2 = standing2.copyWith(wins: standing2.wins + 1, points: standing2.points + 3);
      standing1 = standing1.copyWith(losses: standing1.losses + 1);
    } else { // Draw
      standing1 = standing1.copyWith(draws: standing1.draws + 1, points: standing1.points + 1);
      standing2 = standing2.copyWith(draws: standing2.draws + 1, points: standing2.points + 1);
    }

    // Save updated standings
    await standingsBox.put(standing1.team.id, standing1);
    await standingsBox.put(standing2.team.id, standing2);
  }

  @override
  Future<List<LeagueStanding>> getLeagueStandings() async {
    final standings = standingsBox.values.toList();
    standings.sort((a, b) => b.points.compareTo(a.points));
    return standings;
  }

  @override
  Future<void> saveNewsItem(NewsItem newsItem) async {
    await newsBox.put(newsItem.id, newsItem);
  }
  
  @override
  Future<List<NewsItem>> getNews() async {
    return newsBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}