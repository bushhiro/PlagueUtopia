import '../entities/location_entity.dart';
import '../entities/plague_entity.dart';

class PlagueInfect {
  void call(PlagueEntity plague, LocationEntity location) {
    // все врачи уходят в карантин
    // подчинённые вне карантина умирают
    // защищённые подчинённые остаются
  }
}