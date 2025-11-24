import '../domain/entities/doctor_entity.dart';
import '../domain/entities/location_entity.dart';
import '../domain/entities/player_entity.dart';
import '../domain/entities/subordinate_entity.dart';
import '../domain/usecases/move_character.dart';

class GameController {
  final List<PlayerEntity> players;
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;
  final MoveCharacter moveUseCase;

  MovePhase phase = MovePhase.initialPlacement;
  int activePlayerIndex = 0;

  GameController({
    required this.players,
    required this.doctors,
    required this.subordinates,
  }) : moveUseCase = MoveCharacter(doctors: doctors, subordinates: subordinates);

  PlayerEntity get activePlayer => players[activePlayerIndex];

  /// Пытается переместить персонажа на новую локацию
  MoveResult move({
    DoctorEntity? doctor,
    SubordinateEntity? subordinate,
    required LocationEntity location,
  }) {
    final success = moveUseCase.call(
      doctor: doctor,
      subordinate: subordinate,
      newLocation: location,
      phase: phase,
      playerColor: activePlayer.color,
    );

    return success;
  }

  /// Переход к следующему игроку
  void nextPlayerTurn() {
    activePlayerIndex = (activePlayerIndex + 1) % players.length;
  }

  /// Переход к следующей фазе
  void nextPhase() {
    phase = phase == MovePhase.initialPlacement ? MovePhase.normal : phase;
  }
}