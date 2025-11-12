import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.id,
    required super.adjacentLocations,
    super.canCrossRiver,
  });

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      adjacentLocations: List.from(entity.adjacentLocations),
      canCrossRiver: entity.canCrossRiver,
    );
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      adjacentLocations: List.from(adjacentLocations),
      canCrossRiver: canCrossRiver,
    );
  }
}