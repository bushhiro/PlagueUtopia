import '../../../domain/entities/doctor_entity.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/subordinate_entity.dart';
import '../../../domain/usecases/move_character.dart';

abstract class GameEvent {}

class InitializeGame extends GameEvent {}

class NextPlayerTurn extends GameEvent {}

class ChangePhase extends GameEvent {
  final MovePhase newPhase;
  ChangePhase(this.newPhase);
}

class MoveCharacterEvent extends GameEvent {
  final DoctorEntity? doctor;
  final SubordinateEntity? subordinate;
  final LocationEntity newLocation;
  final PlayerColor playerColor;
  final MovePhase phase;

  MoveCharacterEvent({
    this.doctor,
    this.subordinate,
    required this.newLocation,
    required this.playerColor,
    required this.phase,
  });
}