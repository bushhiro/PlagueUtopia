// lib/feature/game/presentation/blocs/game_bloc/game_bloc.dart
import 'package:bloc/bloc.dart';
import '../../../domain/usecases/move_character.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial()) {
    on<InitializeGame>(_onInitialize);
    on<NextPlayerTurn>(_onNextTurn);
    on<ChangePhase>(_onChangePhase);
    on<MoveCharacterEvent>(_onMoveCharacter);
    on<UpdatePlacedCharacters>(_onUpdatePlaced);
  }

  void _onInitialize(InitializeGame event, Emitter<GameState> emit) {
    // в инициализации нужно установить players/doctors/subordinates/plague
    // сейчас предполагаем, что GameState.initial() вызывается с StaticGameData в другом месте,
    // либо тут можно подгрузить StaticGameData.players и т.д.
    emit(state);
  }

  void _onUpdatePlaced(UpdatePlacedCharacters event, Emitter<GameState> emit) {
    emit(state.copyWith(placedCharacterIds: List<int>.from(event.placedCharacterIds)));
  }

  /// Поиск следующего игрока в фазе initialPlacement:
  /// Чума должна ходить однажды в начале (помечается id -1).
  /// После этого каждый игрок по очереди ставит ВСЕХ своих персонажей (в нашем UI/логике — игрок ставит по одному за ход,
  /// а NextPlayerTurn переводит к следующему игроку, у которого ещё остались нерасставленные персонажи).
  void _onNextTurn(NextPlayerTurn event, Emitter<GameState> emit) {
    final players = state.players;
    if (players.isEmpty) {
      emit(state);
      return;
    }

    // Если мы в нормальной фазе — просто следующий индекс
    if (state.phase != MovePhase.initialPlacement) {
      final nextIndex = (state.activePlayerIndex + 1) % players.length;
      emit(state.copyWith(activePlayerIndex: nextIndex));
      return;
    }

    // Иначе — ищем следующего игрока, у которого есть нерасставленные персонажи (или чума, если ещё не ходила)
    int candidate = state.activePlayerIndex;
    bool found = false;

    for (int i = 0; i < players.length; i++) {
      candidate = (candidate + 1) % players.length;
      final p = players[candidate];

      if (p.isPlague) {
        // если чума ещё не помечена в placedCharacterIds => она должна ходить
        if (!state.placedCharacterIds.contains(-1)) {
          found = true;
          break;
        } else {
          // чума уже ходила — пропускаем
          continue;
        }
      } else {
        // игрок — врачи: проверим, есть ли у этого игрока непомеченные персонажи
        final doc = p.doctor;
        bool hasUnplaced = false;

        if (doc != null) {
          // 1. Проверяем врача
          if (!state.placedCharacterIds.contains(doc.id)) {
            hasUnplaced = true;
          }

          // 2. Проверяем ВСЕХ подчинённых этого цвета (а не doctor.subordinates)
          final playerSubs = state.subordinates.where((s) => s.color == p.color);

          for (final s in playerSubs) {
            if (!state.placedCharacterIds.contains(s.id)) {
              hasUnplaced = true;
              break;
            }
          }
        }

        if (hasUnplaced) {
          found = true;
          break;
        }
        if (hasUnplaced) {
          found = true;
          break;
        } else {
          // этот игрок полностью расставлен — пропускаем
          continue;
        }
      }
    }

    if (!found) {
      // никто не найден — значит initialPlacement завершена
      emit(state.copyWith(phase: MovePhase.normal));
      return;
    }

    emit(state.copyWith(activePlayerIndex: candidate));
  }

  void _onChangePhase(ChangePhase event, Emitter<GameState> emit) {
    emit(state.copyWith(phase: event.newPhase));
  }

  void _onMoveCharacter(MoveCharacterEvent event, Emitter<GameState> emit) {
    final useCase = MoveCharacter(
      doctors: state.doctors,
      subordinates: state.subordinates,
      plague: state.plague,
    );

    final result = useCase.call(
      doctor: event.doctor,
      subordinate: event.subordinate,
      newLocation: event.newLocation,
      phase: event.phase,
      playerColor: event.playerColor,
      placedCharacterIds: state.placedCharacterIds,
    );

    if (result.success) {
      // Если это initialPlacement — нужно обновить placedCharacterIds:
      if (event.phase == MovePhase.initialPlacement) {
        final updated = List<int>.from(state.placedCharacterIds);
        if (event.doctor != null) {
          updated.add(event.doctor.id);
        } else if (event.subordinate != null) {
          updated.add(event.subordinate.id);
        } else {
          // ход чумы — помечаем -1
          updated.add(-1);
        }
        emit(state.copyWith(placedCharacterIds: updated));
      } else {
        // normal move — просто эмитим текущее состояние, т.к. объекты уже изменены по ссылке
        emit(state.copyWith());
      }
    } else {
      // неуспех — можно логировать reason; оставляем состояние без изменений
      emit(state.copyWith());
    }
  }
}