import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_football_league/domain/usecases/get_news_use_case.dart';
import 'package:galactic_football_league/presentation/features/news/bloc/news_event.dart';
import 'package:galactic_football_league/presentation/features/news/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsBloc({required this.getNewsUseCase}) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final newsItems = await getNewsUseCase();
      emit(NewsLoaded(newsItems));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}