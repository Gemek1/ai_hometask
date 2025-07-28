import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_football_league/domain/usecases/get_match_history_use_case.dart';
import 'package:galactic_football_league/presentation/features/match_history/bloc/match_history_event.dart';
import 'package:galactic_football_league/presentation/features/match_history/bloc/match_history_state.dart';

class MatchHistoryBloc extends Bloc<MatchHistoryEvent, MatchHistoryState> {
  final GetMatchHistoryUseCase getMatchHistoryUseCase;

  MatchHistoryBloc({required this.getMatchHistoryUseCase}) : super(HistoryInitial()) {
    on<LoadMatchHistory>(_onLoadMatchHistory);
  }

  Future<void> _onLoadMatchHistory(
    LoadMatchHistory event,
    Emitter<MatchHistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final results = await getMatchHistoryUseCase();
      emit(HistoryLoaded(results));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}