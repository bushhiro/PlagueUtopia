import '../../domain/entities/plague_entity.dart';
import 'location_model.dart';
import 'subordinate_model.dart';

class PlagueModel {
  final int id;
  final int victoryPoints;
  final LocationModel position;
  final List<SubordinateModel> targets;

  PlagueModel({
    required this.id,
    required this.victoryPoints,
    required this.position,
    required this.targets,
  });

  factory PlagueModel.fromEntity(PlagueEntity entity) {
    return PlagueModel(
      id: entity.id,
      victoryPoints: entity.victoryPoints,
      position: LocationModel.fromEntity(entity.position),
      targets: entity.targets
          .map((s) => SubordinateModel.fromEntity(s))
          .toList(),
    );
  }

  PlagueEntity toEntity() {
    return PlagueEntity(
      id: id,
      victoryPoints: victoryPoints,
      position: position.toEntity(),
      targets: targets.map((s) => s.toEntity()).toList(),
    );
  }
}