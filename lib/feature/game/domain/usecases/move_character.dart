// lib/feature/game/domain/usecases/move_character.dart
import '../entities/location_entity.dart';
import '../entities/plague_entity.dart';
import '../entities/subordinate_entity.dart';
import '../entities/doctor_entity.dart';
import '../entities/player_entity.dart';

enum MovePhase {
  initialPlacement,
  normal,
}

class MoveResult {
  final bool success;
  final String? reason;
  MoveResult(this.success, {this.reason});
}

/// UseCase для перемещения персонажей.
/// placedCharacterIds — список id уже расставленных персонажей в initialPlacement.
/// Для Чумы мы помечаем placed id как -1 (конвенция).
class MoveCharacter {
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;
  final PlagueEntity? plague;

  MoveCharacter({
    required this.doctors,
    required this.subordinates,
    this.plague,
  });

  bool _isLocationOccupiedByCharacters(LocationEntity loc) {
    // проверяем всех врачей и всех подчинённых (но НЕ Чуму)
    final occDoctor = doctors.any((d) => d.position.id == loc.id);
    final occSub = subordinates.any((s) => s.position.id == loc.id);
    return occDoctor || occSub;
  }

  MoveResult call({
    DoctorEntity? doctor,
    SubordinateEntity? subordinate,
    required LocationEntity newLocation,
    required MovePhase phase,
    required PlayerColor playerColor,
    List<int>? placedCharacterIds,
  }) {
    final placed = placedCharacterIds ?? [];

    // ===== INITIAL PLACEMENT =====
    if (phase == MovePhase.initialPlacement) {
      // Чума ставится отдельно: если передан ни врач, ни подчинённый — трактуем как ход Чумы
      if (plague != null && doctor == null && subordinate == null) {
        // Чума может ставить в любую локацию, даже если там кто-то стоит
        plague!.position = newLocation;
        return MoveResult(true);
      }

      // Если выбран врач/подчинённый — он может ставиться только своего цвета
      if (doctor != null && doctor.color != playerColor) {
        return MoveResult(false, reason: 'Доктор не того цвета');
      }
      if (subordinate != null && subordinate.color != playerColor) {
        return MoveResult(false, reason: 'Подчинённый не того цвета');
      }

      // Нельзя ставить уже расставленного персонажа
      if (doctor != null && placed.contains(doctor.id)) {
        return MoveResult(false, reason: 'Врач уже расставлен');
      }
      if (subordinate != null && placed.contains(subordinate.id)) {
        return MoveResult(false, reason: 'Подчинённый уже расставлен');
      }

      // На этапе расстановки локация должна быть свободна среди всех персонажей (исключая чуму)
      if (_isLocationOccupiedByCharacters(newLocation)) {
        return MoveResult(false, reason: 'Локация занята');
      }

      // Выполняем расстановку
      if (doctor != null) {
        doctor.position = newLocation;
        return MoveResult(true);
      } else if (subordinate != null) {
        subordinate.position = newLocation;
        return MoveResult(true);
      }

      return MoveResult(false, reason: 'Неверный выбор персонажа');
    }

    // ===== NORMAL MOVE =====
    if (phase == MovePhase.normal) {
      // Доктора: цвет врача должен соответствовать игроку
      if (doctor != null && doctor.color != playerColor) {
        return MoveResult(false, reason: 'Доктор не вашего цвета');
      }
      // Подчинённый: цвет не проверяется при обычном ходе

      // Определяем текущее положение
      final currentPos = doctor?.position ?? subordinate?.position;
      if (currentPos == null) return MoveResult(false, reason: 'Персонаж не на карте');

      // Разрешено двигаться только в соседнюю локацию
      if (!currentPos.adjacentLocations.contains(newLocation.id)) {
        return MoveResult(false, reason: 'Нельзя так далеко перемещаться');
      }

      // Проверка на пересечение реки: проверка единая — если локация помечена canCrossRiver == false,
      // значит переход туда запрещён (мы предполагаем, что currentPos -> newLocation может требовать перехода через реку).
      // (Если нужно более сложная логика — обход мостов и т.д. — её можно добавить).
      if (!newLocation.canCrossRiver) {
        return MoveResult(false, reason: 'Нельзя перейти в эту локацию (река)');
      }

      // В normal'е нескольким персонажам разрешено быть в одной локации — поэтому не проверяем занятость.
      if (doctor != null) {
        doctor.position = newLocation;
        return MoveResult(true);
      } else if (subordinate != null) {
        subordinate.position = newLocation;
        return MoveResult(true);
      }

      return MoveResult(false, reason: 'Неверный выбор персонажа');
    }

    return MoveResult(false, reason: 'Неподдерживаемая фаза');
  }
}