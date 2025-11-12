import 'package:flutter/material.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/subordinate_entity.dart';

class SubordinateWidget extends StatelessWidget {
  final SubordinateEntity subordinate;
  final LocationViewModel locationView;

  const SubordinateWidget({
    super.key,
    required this.subordinate,
    required this.locationView,
  });

  @override
  Widget build(BuildContext context) {
    final color = _resolveColor(subordinate.color as String);

    return Positioned(
      left: MediaQuery.of(context).size.width * locationView.xPercent,
      top: MediaQuery.of(context).size.height * locationView.yPercent,
      child: GestureDetector(
        onTap: () {
          debugPrint(
              'Tapped subordinate ID: ${subordinate.id}, owner: ${subordinate.ownerDoctor?.id}, color: ${subordinate.ownerDoctor?.color}');
        },
        child: CircleAvatar(
          radius: 14,
          backgroundColor: color,
          child: const Icon(Icons.engineering, color: Colors.white, size: 14),
        ),
      ),
    );
  }

  Color _resolveColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}