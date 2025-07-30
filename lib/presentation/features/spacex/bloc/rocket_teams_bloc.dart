import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_football_league/domain/usecases/get_rocket_teams_use_case.dart';
import 'rocket_teams_event.dart';
import 'rocket_teams_state.dart';

class RocketTeamsBloc extends Bloc<RocketTeamsEvent, RocketTeamsState> {
  final GetRocketTeamsUseCase getRocketTeamsUseCase;

  RocketTeamsBloc({required this.getRocketTeamsUseCase}) : super(RocketTeamsInitial()) {
    on<FetchRocketTeams>(_onFetchRocketTeams);
  }

  Future<void> _onFetchRocketTeams(
    FetchRocketTeams event,
    Emitter<RocketTeamsState> emit,
  ) async {
    // 1. Сразу сообщаем UI, что началась загрузка
    emit(RocketTeamsLoading());
    try {
      // 2. Выполняем запрос
      final teams = await getRocketTeamsUseCase.call();
      // 3. Если всё успешно - передаем данные в UI
      emit(RocketTeamsLoaded(teams));
    } catch (e) {
      // 4. Если произошла любая ошибка - сообщаем об этом UI
      emit(RocketTeamsError(e.toString()));
    }
  }
}