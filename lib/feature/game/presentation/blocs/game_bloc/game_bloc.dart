import '../../../domain/usecases/move_character.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'package:bloc/bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<InitializeGame>(_onInitialize);
    on<NextPlayerTurn>(_onNextTurn);
    on<ChangePhase>(_onChangePhase);
    on<MoveCharacterEvent>(_onMoveCharacter);
  }

  void _onInitialize(InitializeGame event, Emitter<GameState> emit) {
    // Здесь будет логика начальной инициализации игры (создание игроков, врачей, подчинённых)
    emit(GameState.initial());
  }

  void _onNextTurn(NextPlayerTurn event, Emitter<GameState> emit) {
    final nextIndex = (state.activePlayerIndex + 1) % state.players.length;
    emit(state.copyWith(activePlayerIndex: nextIndex));
  }

  void _onChangePhase(ChangePhase event, Emitter<GameState> emit) {
    emit(state.copyWith(phase: event.newPhase));
  }

  void _onMoveCharacter(MoveCharacterEvent event, Emitter<GameState> emit) {
    final moveUseCase = MoveCharacter(
      doctors: state.doctors,
      subordinates: state.subordinates,
    );

    final success = moveUseCase.call(
      doctor: event.doctor,
      subordinate: event.subordinate,
      newLocation: event.newLocation,
      phase: event.phase,
      playerColor: event.playerColor,
    );

    if (success) {
      emit(state.copyWith());
    }
  }
}