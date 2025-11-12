import 'package:mor_utopia/feature/game/domain/entities/location_entity.dart';

import 'subordinate_entity.dart';

class PlagueEntity {
  final int id;                        // уникальный идентификатор Чумы
  int victoryPoints;                   // очки победы (можно для расширения, если будут условия для победы)
  final List<SubordinateEntity> targets; // список выбранных подчинённых для убийства
  bool hasMoved;                       // флаг перемещения за ход
  LocationEntity position;

  PlagueEntity({
    required this.id,
    required this.position,
    this.victoryPoints = 0,
    required this.targets,
    this.hasMoved = false,
  });
}