import '../entities/doctor_entity.dart';
import '../entities/subordinate_entity.dart';
import '../entities/resource_entity.dart';

class GenerateResource {
  /// Генерирует ресурс подчинённым или врачом
  /// Если вызвано врачом — врач сам выбирает тип ресурса
  /// Если вызвано подчинённым — добавляет его ресурс врачу
  void call({
    SubordinateEntity? subordinate,
    DoctorEntity? doctor,
    ResourceType? selectedResource, // ресурс, который выбирает врач
  }) {
    if (doctor != null) {
      // Врач может генерировать любой ресурс
      if (selectedResource == null) {
        throw Exception("Врач должен выбрать тип ресурса");
      }
      doctor.resources.add(selectedResource);
    } else if (subordinate != null) {
      final askingDoctor = subordinate.askingDoctor;

      if (subordinate.ownerDoctor != null) {
        // проверяем, что askingDoctor совпадает с ownerDoctor
        if (askingDoctor == subordinate.ownerDoctor) {
          askingDoctor?.resources.add(subordinate.resourceType);
        } else {
          // подчинённый не может отдать ресурс другому врачу
          return;
        }
      } else {
        // свободный подчинённый, может отдать ресурс любому врачу
        askingDoctor?.resources.add(subordinate.resourceType);
      }
    } else {
      throw Exception("Не указан ни врач, ни подчинённый для генерации ресурса");
    }
  }
}