import '../entities/plague_entity.dart';
import '../entities/subordinate_entity.dart';

abstract class PlagueRepository {
  PlagueEntity getPlague();
  void updatePlague(PlagueEntity plague);
  void addVictoryPoint(SubordinateEntity subordinate);
}