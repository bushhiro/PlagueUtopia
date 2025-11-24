// lib/feature/game/presentation/blocs/game_bloc/game_event.dart
abstract class GameEvent {}

class InitializeGame extends GameEvent {}

class NextPlayerTurn extends GameEvent {}

class ChangePhase extends GameEvent {
  final dynamic newPhase;
  ChangePhase(this.newPhase);
}

class MoveCharacterEvent extends GameEvent {
  final dynamic doctor;
  final dynamic subordinate;
  final dynamic newLocation;
  final dynamic phase;
  final dynamic playerColor;
  MoveCharacterEvent({
    this.doctor,
    this.subordinate,
    this.newLocation,
    this.phase,
    this.playerColor,
  });
}

/// Новое событие для обновления placedCharacterIds
class UpdatePlacedCharacters extends GameEvent {
  final List<int> placedCharacterIds;
  UpdatePlacedCharacters(this.placedCharacterIds);
}