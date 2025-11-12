import 'location_entity.dart';

enum StrainType {
  harmful,     // наносит вред врачам/подчинённым
  beneficial,  // даёт Чуме бонус
  neutral,     // не влияет напрямую
}

class StrainEntity {
  final int id;              // уникальный идентификатор штамма
  final String asset;        // путь к ассету штамма
  final StrainType type;     // тип штамма
  final LocationEntity position;

  StrainEntity({
    required this.id,
    required this.asset,
    required this.type,
    required this.position
  });
}