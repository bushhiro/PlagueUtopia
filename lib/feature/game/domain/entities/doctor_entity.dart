import 'package:mor_utopia/feature/game/domain/entities/player_entity.dart';

import 'resource_entity.dart';
import 'location_entity.dart';
import 'subordinate_entity.dart';

class DoctorEntity {
  final int id;                   // уникальный идентификатор врача
  final String asset;                  // путь к ассету
  final List<SubordinateEntity> subordinates; // список подчинённых
  PlayerColor color;
  LocationEntity position;
  final String? name;
  bool isInQuarantine;            // врач сам в карантине (по правилам, можно расширить для других эффектов)
  List<ResourceType> resources;

  DoctorEntity({
    required this.id,
    required this.asset,
    required this.subordinates,
    required this.color,
    required this.position,
    this.name,
    this.isInQuarantine = true,
    List<ResourceType>? resources,
  }) : resources = resources ?? [];
}