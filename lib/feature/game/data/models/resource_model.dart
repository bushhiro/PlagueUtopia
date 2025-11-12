import '../../domain/entities/resource_entity.dart';

class ResourceModel extends ResourceEntity {
  ResourceModel({required super.type});

  /// Entity → Model
  factory ResourceModel.fromEntity(ResourceEntity entity) {
    return ResourceModel(type: entity.type);
  }

  /// Model → Entity
  ResourceEntity toEntity() {
    return ResourceEntity(type: type);
  }
}