enum ResourceType {
  letter,
  coin,
  key,
}

class ResourceEntity {
  final ResourceType type; // тип ресурса

  ResourceEntity({
    required this.type,
  });
}