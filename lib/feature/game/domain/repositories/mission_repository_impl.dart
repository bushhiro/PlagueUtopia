import '../entities/mission_entity.dart';

abstract class MissionRepository {
  List<MissionEntity> getAllMissions();
  List<MissionEntity> getActiveMissions();
  MissionEntity drawMission();
  void completeMission(MissionEntity mission);
}