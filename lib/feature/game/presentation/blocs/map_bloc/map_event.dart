import '../../../domain/entities/location_entity.dart';
import '../../../domain/entities/doctor_entity.dart';
import '../../../domain/entities/subordinate_entity.dart';

abstract class MapEvent {}

class UpdateDoctorPosition extends MapEvent {
  final DoctorEntity doctor;
  final LocationEntity newLocation;
  UpdateDoctorPosition(this.doctor, this.newLocation);
}

class UpdateSubordinatePosition extends MapEvent {
  final SubordinateEntity subordinate;
  final LocationEntity newLocation;
  UpdateSubordinatePosition(this.subordinate, this.newLocation);
}