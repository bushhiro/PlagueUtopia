import '../../../domain/entities/doctor_entity.dart';
import '../../../domain/entities/subordinate_entity.dart';

class MapState {
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;

  MapState({required this.doctors, required this.subordinates});

  factory MapState.initial() => MapState(doctors: [], subordinates: []);

  MapState copyWith({
    List<DoctorEntity>? doctors,
    List<SubordinateEntity>? subordinates,
  }) {
    return MapState(
      doctors: doctors ?? this.doctors,
      subordinates: subordinates ?? this.subordinates,
    );
  }
}