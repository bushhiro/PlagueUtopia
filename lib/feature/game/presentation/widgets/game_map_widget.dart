import 'package:flutter/material.dart';
import '../../data/models/mission_model.dart';
import 'doctor_widget.dart';
import 'subordinate_widget.dart';
import 'plague_widget.dart';
import 'mission_widget.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import '../../domain/entities/plague_entity.dart';

class GameMapWidget extends StatelessWidget {
  final List<DoctorEntity> doctors;
  final List<SubordinateEntity> subordinates;
  final PlagueEntity plague;
  final List<MissionModel> missions; // <-- используем MissionModel

  const GameMapWidget({
    super.key,
    required this.doctors,
    required this.subordinates,
    required this.plague,
    required this.missions,
  });

  @override
  Widget build(BuildContext context) {
    const mapAspectRatio = 958 / 592;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: mapAspectRatio,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final mapWidth = constraints.maxWidth;
              final mapHeight = constraints.maxHeight;

              return Stack(
                children: [
                  /// Фон карты
                  Positioned.fill(
                    child: Image.asset(
                      'lib/core/assets/utopia_map.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Размещение миссий
                  for (final mission in missions)
                    Positioned(
                      left: mapWidth * mission.locationView.xPercent / 100,
                      top: mapHeight * mission.locationView.yPercent / 100,
                      child: MissionWidget(
                        mission: mission,
                        viewPosition: mission.locationView,
                        mapWidth: mapWidth,
                        mapHeight: mapHeight,
                        mapRatio: mapAspectRatio,
                      ),
                    ),
                ],
              );
            },
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
      ],
    );
  }
}