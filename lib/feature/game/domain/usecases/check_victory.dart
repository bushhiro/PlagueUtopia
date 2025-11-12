import '../entities/plague_entity.dart';
import '../entities/player_entity.dart';

class CheckVictory {
  bool call(List<PlayerEntity> players, PlagueEntity plague) {
    for (var player in players) {
      if (!player.isPlague && player.victoryPoints >= 8) return true;

      if(player.isPlague && player.victoryPoints == 3) return true;
    }

    return false;
  }
}