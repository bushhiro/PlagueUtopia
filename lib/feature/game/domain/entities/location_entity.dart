class LocationEntity {
  final int id;            // уникальный идентификатор локации
  final List<int> adjacentLocations; // список ID соседних локаций
  final bool canCrossRiver; // можно ли переходить через реку в эту локацию


  LocationEntity({
    required this.id,
    required this.adjacentLocations,
    this.canCrossRiver = true,
  });
}

class LocationViewModel {
  final double xPercent;
  final double yPercent;

  const LocationViewModel({
    required this.xPercent,
    required this.yPercent,
    required String asset,
  });
}