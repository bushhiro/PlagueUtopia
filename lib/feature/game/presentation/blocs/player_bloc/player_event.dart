import '../../../domain/entities/player_entity.dart';

abstract class PlayerEvent {}

class AddVictoryPoints extends PlayerEvent {
  final PlayerEntity player;
  final int points;
  AddVictoryPoints(this.player, this.points);
}

class UpdatePlayerStatus extends PlayerEvent {
  final PlayerEntity player;
  UpdatePlayerStatus(this.player);
}