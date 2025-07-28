import 'package:equatable/equatable.dart';
import 'package:galactic_football_league/domain/models/news_item.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsItem> newsItems;

  const NewsLoaded(this.newsItems);

  @override
  List<Object> get props => [newsItems];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}