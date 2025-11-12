import '../entities/doctor_entity.dart';

abstract class DoctorRepository {
  List<DoctorEntity> getAllDoctors();
  DoctorEntity getDoctorById(int id);
  void updateDoctor(DoctorEntity doctor);
}