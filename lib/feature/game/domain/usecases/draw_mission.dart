import '../entities/mission_entity.dart';
import '../repositories/mission_repository_impl.dart';

class DrawMission {
  final MissionRepository missionRepository;

  DrawMission(this.missionRepository);

  MissionEntity call() {
    if (missionRepository.getActiveMissions().length >= 4) {
      throw Exception("На карте уже 4 миссии");
    }

    return missionRepository.drawMission();
  }
}