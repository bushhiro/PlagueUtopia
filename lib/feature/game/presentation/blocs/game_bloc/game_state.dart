import '../../../domain/entities/doctor_entity.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/plague_entity.dart';
import '../../../domain/entities/player_entity.dart';
import '../../../domain/entities/subordinate_entity.dart';
import '../../../domain/usecases/move_character.dart';

class GameState {
  final List<PlayerEntity> players;
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;
  final PlagueEntity plague;
  final MovePhase phase;
  final int activePlayerIndex;

  GameState({
    required this.players,
    required this.doctors,
    required this.subordinates,
    required this.plague,
    required this.phase,
    required this.activePlayerIndex,
  });

  factory GameState.initial() => GameState(
    players: [],
    doctors: [],
    subordinates: [],
    plague: PlagueEntity(id: 0, position: LocationEntity(id: 0, adjacentLocations: []), targets: []),
    phase: MovePhase.initialPlacement,
    activePlayerIndex: 0,
  );

  GameState copyWith({
    List<PlayerEntity>? players,
    List<DoctorEntity>? doctors,
    List<SubordinateEntity>? subordinates,
    PlagueEntity? plague,
    MovePhase? phase,
    int? activePlayerIndex,
  }) {
    return GameState(
      players: players ?? this.players,
      doctors: doctors ?? this.doctors,
      subordinates: subordinates ?? this.subordinates,
      plague: plague ?? this.plague,
      phase: phase ?? this.phase,
      activePlayerIndex: activePlayerIndex ?? this.activePlayerIndex,
    );
  }

  PlayerEntity get activePlayer => players[activePlayerIndex];
}