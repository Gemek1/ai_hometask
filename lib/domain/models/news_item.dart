import 'package:equatable/equatable.dart';

class NewsItem extends Equatable {
  final String id;
  final String title;
  final String contentTemplateKey;
  final DateTime date;
  final String team1Name;
  final String team2Name;
  final int score1;
  final int score2;

  const NewsItem({
    required this.id,
    required this.title,
    required this.contentTemplateKey,
    required this.date,
    required this.team1Name,
    required this.team2Name,
    required this.score1,
    required this.score2,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        contentTemplateKey,
        date,
        team1Name,
        team2Name,
        score1,
        score2
      ];
}