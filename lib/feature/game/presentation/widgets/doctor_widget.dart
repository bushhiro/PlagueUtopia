import 'package:flutter/material.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/location_entity.dart';

class DoctorWidget extends StatelessWidget {
  final DoctorEntity doctor;
  final LocationViewModel locationView;

  const DoctorWidget({
    super.key,
    required this.doctor,
    required this.locationView,
  });

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(doctor.color as String);

    return Positioned(
      left: MediaQuery.of(context).size.width * locationView.xPercent,
      top: MediaQuery.of(context).size.height * locationView.yPercent,
      child: GestureDetector(
        onTap: () {
          debugPrint('Tapped on Doctor ID: ${doctor.id}, color: ${doctor.color}');
        },
        child: CircleAvatar(
          radius: 18,
          backgroundColor: color,
          child: const Icon(Icons.local_hospital, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  /// Определяет цвет по строковому значению из сущности врача
  Color _resolveColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}