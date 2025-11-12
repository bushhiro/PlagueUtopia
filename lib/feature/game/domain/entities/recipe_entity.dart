enum RecipeType {
  influence, // Влияние
  action,    // Действие
  reaction,  // Реакция
}

class RecipeEntity {
  final int id;               // уникальный идентификатор рецепта
  final String asset;         // путь к ассету карточки рецепта
  final RecipeType type;      // тип рецепта
  final String effect;        // текстовое описание эффекта (можно потом расширить в класс эффектов)

  RecipeEntity({
    required this.id,
    required this.asset,
    required this.type,
    required this.effect,
  });
}