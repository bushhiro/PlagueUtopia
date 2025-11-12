import '../entities/mission_entity.dart';
import '../entities/player_entity.dart';
import '../entities/doctor_entity.dart';
import '../entities/subordinate_entity.dart';
import '../repositories/mission_repository_impl.dart';

class CompleteMission {
  final MissionRepository missionRepository;

  CompleteMission(this.missionRepository);

  /// Выполняет миссию
  /// [performerDoctor] — если миссию выполняет врач
  /// [performerSubordinate] — если миссию выполняет подчинённый
  void call({
    required MissionEntity mission,
    required PlayerEntity player,
    DoctorEntity? performerDoctor,
    SubordinateEntity? performerSubordinate,
  }) {
    if (performerDoctor != null) {
      // Врач всегда +1 очко
      player.victoryPoints += 1;
    } else if (performerSubordinate != null) {
      // Подчинённый
      if (performerSubordinate.color == performerSubordinate.askingDoctor?.color) {
        // Если цвет подчинённого совпадает с врачом, который его попросил
        player.victoryPoints += 2;
      } else {
        player.victoryPoints += 1;
      }
    } else {
      throw Exception("Ни врач, ни подчинённый не указан для выполнения миссии");
    }

    // помечаем миссию выполненной
    missionRepository.completeMission(mission);
  }
}