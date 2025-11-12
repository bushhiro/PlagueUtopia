import 'package:mor_utopia/feature/game/domain/entities/player_entity.dart';

import 'doctor_entity.dart';
import 'resource_entity.dart';
import 'location_entity.dart';

enum SubordinateStatus {
  inQuarantine,
  outOfQuarantine,
  dead,
}

class SubordinateEntity {
  final int id;                     // уникальный идентификатор подчинённого
  final String asset;                  // путь к ассету
  final ResourceType resourceType;  // ресурс, который может генерировать подчинённый
  final PlayerColor color;
  LocationEntity position;
  final String? name;
  SubordinateStatus status;         // текущее состояние
  DoctorEntity? ownerDoctor;       // ссылка на врача-владельца
  DoctorEntity? askingDoctor;       // ссылка на врача-владельца


  SubordinateEntity({
    required this.id,
    required this.asset,
    required this.resourceType,
    required this.color,
    required this.position,
    this.name,
    this.status = SubordinateStatus.inQuarantine,
    this.ownerDoctor,
    this.askingDoctor,
  });
}