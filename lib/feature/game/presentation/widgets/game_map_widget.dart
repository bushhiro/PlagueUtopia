import 'package:flutter/material.dart';
import 'package:mor_utopia/feature/game/domain/entities/location_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/plague_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import 'doctor_widget.dart';
import 'subordinate_widget.dart';
import 'plague_widget.dart';

class GameMapWidget extends StatelessWidget {
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;
  final PlagueEntity plague;

  const GameMapWidget({
    super.key,
    required this.doctors,
    required this.subordinates,
    required this.plague,
  });

  @override
  Widget build(BuildContext context) {
    // Соотношение сторон карты: 958 / 592
    const mapAspectRatio = 958 / 592;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: mapAspectRatio,
          child: Stack(
            children: [
              /// Фон карты
              Positioned.fill(
                child: Image.asset(
                  'lib/core/assets/utopia_map.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              /// Размещение врачей
              for (final doctor in doctors)
                DoctorWidget(
                  doctor: doctor,
                  locationView: doctor.position as LocationViewModel,
                ),

              /// Размещение подчинённых
              for (final sub in subordinates)
                SubordinateWidget(
                  subordinate: sub,
                  locationView: sub.position as LocationViewModel,
                ),

              /// Размещение чумы
              PlagueWidget(plague: plague),
            ],
          ),
        ),

        Expanded(
          child: Container(
            color: Colors.grey.shade300,
            child: const Center(
              child: Text('Здесь будет нижняя панель игроков'),
            ),
          ),
        ),
      ]
    );
  }
}