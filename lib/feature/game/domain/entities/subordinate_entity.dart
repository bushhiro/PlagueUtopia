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
  PlayerColor color;
  final ResourceType resourceType;  // ресурс, который может генерировать подчинённый
  SubordinateStatus status;         // текущее состояние
  LocationEntity position;
  DoctorEntity? ownerDoctor;       // ссылка на врача-владельца
  DoctorEntity? askingDoctor;       // ссылка на врача-владельца


  SubordinateEntity({
    required this.id,
    required this.asset,
    required this.color,
    required this.resourceType,
    this.status = SubordinateStatus.inQuarantine,
    required this.position,
    this.ownerDoctor,
    this.askingDoctor,
  });
}