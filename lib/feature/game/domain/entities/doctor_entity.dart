import 'package:mor_utopia/feature/game/domain/entities/player_entity.dart';

import 'resource_entity.dart';
import 'location_entity.dart';
import 'subordinate_entity.dart';

class DoctorEntity {
  final int id;                   // уникальный идентификатор врача
  final String asset;                  // путь к ассету
  PlayerColor color;
  final List<SubordinateEntity> subordinates; // список подчинённых
  bool isInQuarantine;            // врач сам в карантине (по правилам, можно расширить для других эффектов)
  LocationEntity position;
  List<ResourceType> resources;

  DoctorEntity({
    required this.id,
    required this.asset,
    required this.color,
    required this.subordinates,
    this.isInQuarantine = true,
    required this.position,
    List<ResourceType>? resources,
  }) : resources = resources ?? [];
}