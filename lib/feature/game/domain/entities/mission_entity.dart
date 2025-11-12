import 'resource_entity.dart';

enum MissionEffectType {
  onDraw,      // эффект срабатывает при появлении на карте
  onComplete,  // эффект срабатывает при выполнении
  continuous,  // постоянный эффект
}

class MissionEntity {
  final int id;                        // уникальный идентификатор миссии
  final String asset;                  // путь к ассету карточки миссии
  final MissionEffectType effectType;  // тип эффекта миссии
  final Map<int, ResourceType> resourceCost; // ресурс для выполнения для каждого врача (key = doctorId)
  final bool hasAdditionalCondition;   // есть ли дополнительное условие
  bool isCompleted;
  final bool isDrawn;

  MissionEntity({
    required this.id,
    required this.asset,
    required this.effectType,
    required this.resourceCost,
    this.hasAdditionalCondition = false,
    this.isCompleted = false,
    this.isDrawn = true
  });
}
