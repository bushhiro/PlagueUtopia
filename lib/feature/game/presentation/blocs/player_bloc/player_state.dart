import '../../../domain/entities/player_entity.dart';

class PlayerState {
  final List<PlayerEntity> players;

  PlayerState({required this.players});

  factory PlayerState.initial() => PlayerState(players: []);

  PlayerState copyWith({List<PlayerEntity>? players}) {
    return PlayerState(players: players ?? this.players);
  }
}