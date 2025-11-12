import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/player_entity.dart';
import 'subordinate_model.dart';
import 'location_model.dart';

class DoctorModel {
  final int id;
  final String color;
  final LocationModel position;
  final List<SubordinateModel> subordinates;
  final List<String> resources;
  final String asset;

  DoctorModel({
    required this.id,
    required this.color,
    required this.position,
    required this.subordinates,
    required this.resources,
    required this.asset,
  });

  factory DoctorModel.fromEntity(DoctorEntity entity) {
    return DoctorModel(
      id: entity.id,
      color: entity.color as String,
      position: LocationModel.fromEntity(entity.position),
      subordinates:
      entity.subordinates.map((s) => SubordinateModel.fromEntity(s)).toList(),
      resources: List.from(entity.resources),
      asset: entity.asset,
    );
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      color: color as PlayerColor,
      position: position.toEntity(),
      subordinates: subordinates.map((s) => s.toEntity()).toList(),
      resources: List.from(resources),
      asset: asset,
    );
  }
}