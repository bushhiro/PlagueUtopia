import '../../domain/entities/location_entity.dart';
import '../../domain/entities/mission_entity.dart';

class MissionModel extends MissionEntity {
  // Дополнительно для UI
  final LocationViewModel locationView;

  MissionModel({
    required super.id,
    required super.asset,
    required super.effectType,
    required super.resourceCost,
    required super.isCompleted,
    required this.locationView,
  });

  /// Entity → Model
  factory MissionModel.fromEntity(MissionEntity entity, LocationViewModel locationView) {
    return MissionModel(
      id: entity.id,
      asset: entity.asset,
      effectType: entity.effectType,
      resourceCost: entity.resourceCost,
      isCompleted: entity.isCompleted,
      locationView: locationView,
    );
  }

  /// Model → Entity
  MissionEntity toEntity() {
    return MissionEntity(
      id: id,
      asset: asset,
      effectType: effectType,
      resourceCost: resourceCost,
      isCompleted: isCompleted,
    );
  }
}