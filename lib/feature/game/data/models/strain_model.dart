import '../../domain/entities/location_entity.dart';
import '../../domain/entities/strain_entity.dart';

class StrainModel extends StrainEntity {
  final LocationViewModel locationView; // визуальная позиция для UI

  StrainModel({
    required super.id,
    required super.asset,
    required super.type,
    required super.position,
    required this.locationView,
  });

  /// Entity → Model
  factory StrainModel.fromEntity(StrainEntity entity) {
    return StrainModel(
      id: entity.id,
      asset: entity.asset,
      type: entity.type,
      position: entity.position,
      locationView: LocationViewModel(
        asset: entity.asset,
        xPercent: 0.0, // задайте реальную координату для отображения
        yPercent: 0.0,
      ),
    );
  }

  /// Model → Entity
  StrainEntity toEntity() {
    return StrainEntity(
      id: id,
      asset: asset,
      type: type,
      position: position,
    );
  }
}