import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_football_league/domain/usecases/get_league_standings_use_case.dart';
import 'package:galactic_football_league/presentation/features/leaderboard/bloc/leaderboard_event.dart';
import 'package:galactic_football_league/presentation/features/leaderboard/bloc/leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeagueStandingsUseCase getLeagueStandingsUseCase;

  LeaderboardBloc({required this.getLeagueStandingsUseCase}) : super(LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<RefreshLeaderboard>(_onRefreshLeaderboard);
  }

  Future<void> _onLoadLeaderboard(LoadLeaderboard event, Emitter<LeaderboardState> emit) async {
    emit(LeaderboardLoading());
    try {
      final standings = await getLeagueStandingsUseCase();
      emit(LeaderboardLoaded(standings));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }

  Future<void> _onRefreshLeaderboard(RefreshLeaderboard event, Emitter<LeaderboardState> emit) async {
     // No need to show loading indicator on refresh for a smoother UX
    try {
      final standings = await getLeagueStandingsUseCase();
      emit(LeaderboardLoaded(standings));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }
}