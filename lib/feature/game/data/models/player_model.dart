import '../../domain/entities/player_entity.dart';
import 'doctor_model.dart';
import 'plague_model.dart';

class PlayerModel {
  final int id;
  final bool isPlague;
  final int victoryPoints;
  final DoctorModel? doctor;
  final PlagueModel? plague;
  final PlayerColor color;

  PlayerModel({
    required this.id,
    required this.isPlague,
    required this.victoryPoints,
    required this.color,
    this.doctor,
    this.plague,
  });

  /// Преобразование из сущности (Entity → Model)
  factory PlayerModel.fromEntity(PlayerEntity entity) {
    return PlayerModel(
      id: entity.id,
      isPlague: entity.isPlague,
      victoryPoints: entity.victoryPoints,
      doctor: entity.doctor != null ? DoctorModel.fromEntity(entity.doctor!) : null,
      plague: entity.plague != null ? PlagueModel.fromEntity(entity.plague!) : null,
      color: entity.color,
    );
  }

  /// Преобразование в сущность (Model → Entity)
  PlayerEntity toEntity() {
    return PlayerEntity(
      id: id,
      isPlague: isPlague,
      color: color,
      victoryPoints: victoryPoints,
      doctor: doctor?.toEntity(),
      plague: plague?.toEntity(),
    );
  }
}