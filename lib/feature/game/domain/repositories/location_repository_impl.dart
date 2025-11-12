import '../entities/location_entity.dart';

abstract class LocationRepository {
  List<LocationEntity> getAllLocations();
  LocationEntity getLocationById(int id);
}

LocationViewModel getLocationView(LocationViewModel location) {
  // здесь asset — это картинка локации на карте (можно использовать location.asset)
  return LocationViewModel(
    xPercent: location.xPercent,
    yPercent: location.yPercent,
    asset: '',
  );
}