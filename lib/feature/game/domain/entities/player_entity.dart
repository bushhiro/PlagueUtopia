import 'doctor_entity.dart';
import 'plague_entity.dart';

enum PlayerColor{
  blue,
  red,
  yellow,
  black
}

class PlayerEntity {
  final int id;                 // уникальный идентификатор игрока
  final bool isPlague;          // true, если игрок управляет Чумой
  final PlayerColor color;
  final DoctorEntity? doctor;   // если игрок врач, его главный персонаж
  final PlagueEntity? plague;         // если игрок Чума, объект Чумы
  int victoryPoints;            // очки победы (начиная с 3, для врачей, для Чумы могут быть другие цели)

  PlayerEntity({
    required this.id,
    required this.isPlague,
    required this.color,
    this.doctor,
    this.plague,
    this.victoryPoints = 3,
  });
}