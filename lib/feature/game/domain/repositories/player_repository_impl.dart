import '../entities/player_entity.dart';

abstract class PlayerRepository {
  List<PlayerEntity> getAllPlayers();
  PlayerEntity getPlayerById(int id);
  void updatePlayer(PlayerEntity player);
}