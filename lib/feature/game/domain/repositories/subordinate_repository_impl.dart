import '../entities/subordinate_entity.dart';

abstract class SubordinateRepository {
  List<SubordinateEntity> getAllSubordinates();
  SubordinateEntity getSubordinateById(int id);
  void updateSubordinate(SubordinateEntity subordinate);
}