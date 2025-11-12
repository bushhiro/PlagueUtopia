import 'package:flutter/material.dart';
import '../../domain/entities/plague_entity.dart';

/// Виджет для отображения состояния чумы.
/// По умолчанию она невидима на карте, если не включён "режим раскрытия".
class PlagueWidget extends StatelessWidget {
  final PlagueEntity plague;
  final bool isRevealed; // показывает ли UI текущую позицию чумы

  const PlagueWidget({
    super.key,
    required this.plague,
    this.isRevealed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRevealed) {
      // Чума скрыта — возвращаем пустой виджет
      return const SizedBox.shrink();
    }

    // Если чума раскрыта — показываем её как чёрный символ на карте
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.45,
      top: MediaQuery.of(context).size.height * 0.45,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black,
        child: const Icon(Icons.coronavirus, color: Colors.white, size: 20),
      ),
    );
  }
}