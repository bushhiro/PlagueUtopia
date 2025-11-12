import 'package:mor_utopia/feature/game/domain/entities/player_entity.dart';
import 'package:mor_utopia/feature/game/domain/entities/resource_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import 'location_model.dart';
import 'doctor_model.dart';

class SubordinateModel {
  final int id;
  final String color;
  final SubordinateStatus status;
  final LocationModel position;
  final DoctorModel? ownerDoctor;
  final DoctorModel? askingDoctor;
  final ResourceType resourceType;
  final String asset;

  SubordinateModel({
    required this.id,
    required this.color,
    required this.status,
    required this.position,
    this.ownerDoctor,
    this.askingDoctor,
    required this.resourceType,
    required this.asset,
  });

  /// Преобразование Entity → Model
  factory SubordinateModel.fromEntity(SubordinateEntity entity) {
    return SubordinateModel(
      id: entity.id,
      color: entity.color as String,
      status: entity.status,
      position: LocationModel.fromEntity(entity.position),
      ownerDoctor: entity.ownerDoctor != null
          ? DoctorModel.fromEntity(entity.ownerDoctor!)
          : null,
      askingDoctor: entity.askingDoctor != null
          ? DoctorModel.fromEntity(entity.askingDoctor!)
          : null,
      resourceType: entity.resourceType,
      asset: entity.asset,
    );
  }

  /// Преобразование Model → Entity
  SubordinateEntity toEntity() {
    return SubordinateEntity(
      id: id,
      color: color as PlayerColor,
      status: status,
      position: position.toEntity(),
      ownerDoctor: ownerDoctor?.toEntity(),
      askingDoctor: askingDoctor?.toEntity(),
      resourceType: resourceType,
      asset: asset,
    );
  }
}