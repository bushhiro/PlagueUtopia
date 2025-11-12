import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerState.initial()) {
    on<AddVictoryPoints>(_onAddPoints);
    on<UpdatePlayerStatus>(_onUpdateStatus);
  }

  void _onAddPoints(AddVictoryPoints event, Emitter<PlayerState> emit) {
    final updatedPlayers = state.players.map((p) {
      if (p.id == event.player.id) {
        p.victoryPoints += event.points;
      }
      return p;
    }).toList();

    emit(state.copyWith(players: updatedPlayers));
  }

  void _onUpdateStatus(UpdatePlayerStatus event, Emitter<PlayerState> emit) {
    // например, обновление статуса заражения или смерти
    emit(state.copyWith());
  }
}