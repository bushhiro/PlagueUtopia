import '../entities/strain_entity.dart';

abstract class StrainRepository {
  List<StrainEntity> getAllStrains();
  void addStrainToMap(StrainEntity strain, int locationId);
  void removeStrain(StrainEntity strain);
}