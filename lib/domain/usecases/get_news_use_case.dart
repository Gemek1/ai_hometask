import '../models/news_item.dart';
import '../repositories/match_repository.dart';

class GetNewsUseCase {
  final MatchRepository repository;
  GetNewsUseCase(this.repository);
  Future<List<NewsItem>> call() => repository.getNews();
}