import '../entities/subordinate_entity.dart';
import '../repositories/plague_repository_impl.dart';

class PlagueKillSubordinate {
  final PlagueRepository plagueRepository;

  PlagueKillSubordinate(this.plagueRepository);

  void call(SubordinateEntity subordinate) {

    subordinate.status = SubordinateStatus.dead;

    plagueRepository.addVictoryPoint(subordinate);
  }
}