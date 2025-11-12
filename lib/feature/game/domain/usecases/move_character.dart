import '../entities/location_entity.dart';
import '../entities/subordinate_entity.dart';
import '../entities/doctor_entity.dart';
import '../entities/player_entity.dart';

enum MovePhase {
  initialPlacement, // расстановка персонажей в начале игры
  normal,           // обычное перемещение во время игры
}

class MoveCharacter {
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;

  MoveCharacter({
    required this.doctors,
    required this.subordinates,
  });

  /// Перемещает врача или подчинённого на новую локацию
  /// [phase] указывает, происходит ли расстановка или обычный ход
  /// [playerColor] — цвет игрока, который делает ход
  bool call({
    DoctorEntity? doctor,
    SubordinateEntity? subordinate,
    required LocationEntity newLocation,
    required MovePhase phase,
    required PlayerColor playerColor,
  }) {
    // ===== INITIAL PLACEMENT =====
    if (phase == MovePhase.initialPlacement) {
      // Проверка цвета игрока
      if (doctor != null && doctor.color != playerColor) return false;
      if (subordinate != null && subordinate.color != playerColor) return false;

      // Проверка, что локация свободна
      final occupied = doctors.any((d) => d.position.id == newLocation.id) ||
          subordinates.any((s) => s.position.id == newLocation.id);

      if (occupied) return false; // нельзя ставить персонажа в занятую локацию
    }

    // ===== NORMAL MOVE =====
    if (phase == MovePhase.normal && subordinate != null) {
      // Если подчинённый связан знаком Договора
      if (subordinate.ownerDoctor != null) {
        // Разрешаем движение только если askingDoctor совпадает с ownerDoctor
        if (subordinate.askingDoctor != subordinate.ownerDoctor) {
          return false;
        }
      }
    }

    // ===== ПЕРЕМЕЩЕНИЕ =====
    if (doctor != null) {
      doctor.position = newLocation;
      return true;
    } else if (subordinate != null) {
      subordinate.position = newLocation;
      return true;
    }

    return false;
  }
}