import '../entities/location_entity.dart';
import '../entities/plague_entity.dart';

class PlagueMove {
  /// Все локации карты
  final List<LocationEntity> allLocations;

  PlagueMove({required this.allLocations});

  /// Перемещение Чумы
  /// [currentPlague] — объект Чумы
  /// [targetLocation] — выбранная локация для хода
  /// [canCrossRiver] — проверка, есть ли мост между текущей и целевой локацией
  /// Возвращает true, если перемещение успешно
  bool call({
    required PlagueEntity currentPlague,
    required LocationEntity targetLocation,
    bool canCrossRiver = true,
  }) {
    final currentLocation = currentPlague.position;

    // Если цель — та же локация, просто остаёмся
    if (currentLocation.id == targetLocation.id) {
      return true;
    }

    // Проверяем допустимость перемещения
    final isAdjacent = currentLocation.adjacentLocations.contains(targetLocation.id);

    if (!isAdjacent) return false; // можно перемещаться только в соседние локации

    // Проверка пересечения реки
    if (!targetLocation.canCrossRiver) return false;
    // Перемещение успешно
    currentPlague.position = targetLocation;
    return true;
  }
}