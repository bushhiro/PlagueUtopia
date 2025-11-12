import 'package:flutter/material.dart';
import 'package:mor_utopia/feature/game/domain/entities/mission_entity.dart';
import '../../domain/entities/location_entity.dart';

/// Виджет отдельной миссии на карте
class MissionWidget extends StatelessWidget {
  final MissionEntity mission;
  final LocationViewModel viewPosition;
  final double mapWidth;  // ширина карты
  final double mapHeight; // высота карты
  final double mapRatio;

  const MissionWidget({
    super.key,
    required this.mission,
    required this.viewPosition,
    required this.mapWidth,
    required this.mapHeight,
    required this.mapRatio,
  });

  @override
  Widget build(BuildContext context) {
    final double size = mapRatio * 55;
    final double opacity = mission.isDrawn && !mission.isCompleted ? 1.0 : 0.0;

    return Positioned(
      left: mapWidth * viewPosition.xPercent / 100,
      top: mapHeight * viewPosition.yPercent / 100,
      child: GestureDetector(
        onTap: () => _showMissionDetails(context),
        child: Opacity(
          opacity: opacity,
          child: Column(
            children: [
              Image.asset(
                mission.asset,
                width: size,
                height: size,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMissionDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Миссия #${mission.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Тип: ${mission.effectType.name}'),
            Text('Стоимость ресурсов: ${mission.resourceCost}'),
            Text('Статус: ${mission.isCompleted ? 'Завершена' : 'Активна'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}