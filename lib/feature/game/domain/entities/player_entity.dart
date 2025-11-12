import 'doctor_entity.dart';
import 'plague_entity.dart';

enum PlayerColor{
  blue,
  red,
  yellow
}

class PlayerEntity {
  final int id;                 // уникальный идентификатор игрока
  final bool isPlague;          // true, если игрок управляет Чумой
  int victoryPoints;            // очки победы (начиная с 3, для врачей, для Чумы могут быть другие цели)
  final DoctorEntity? doctor;   // если игрок врач, его главный персонаж
  final PlagueEntity? plague;         // если игрок Чума, объект Чумы

  PlayerEntity({
    required this.id,
    required this.isPlague,
    this.victoryPoints = 3,
    this.doctor,
    this.plague,
  });
}