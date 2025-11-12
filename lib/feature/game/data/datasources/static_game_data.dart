import 'package:mor_utopia/feature/game/domain/entities/player_entity.dart';
import 'package:mor_utopia/feature/game/domain/entities/resource_entity.dart';

import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/mission_entity.dart';
import '../../domain/entities/strain_entity.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/entities/plague_entity.dart';
import '../models/mission_model.dart';

/// Фиксированные игровые данные, не изменяются в ходе игры.
class StaticGameData {

  static final LocationEntity dummyLocation = LocationEntity(
    id: 0,
    adjacentLocations: [],
    canCrossRiver: false
  );

  // === ЛОКАЦИИ ===
  static final List<LocationEntity> locations = [
    LocationEntity(
      id: 1,
      adjacentLocations: [2, 3],
      canCrossRiver: false,
    ),
    LocationEntity(
      id: 2,
      adjacentLocations: [1, 4],
      canCrossRiver: true,
    ),
    LocationEntity(
      id: 3,
      adjacentLocations: [1],
    ),
    LocationEntity(
      id: 4,
      adjacentLocations: [2],
    ),
  ];

  // === ВРАЧИ ===
  static final List<DoctorEntity> doctors = [
    DoctorEntity(
      id: 1,
      name: 'Doc1',
      color: PlayerColor.blue,
      position: dummyLocation,
      asset: '',
      subordinates: [],
    ),
    DoctorEntity(
      id: 2,
      name: 'Doc2',
      color: PlayerColor.red,
      position: dummyLocation,
      asset: '',
      subordinates: [],
    ),
    DoctorEntity(
      id: 3,
      name: 'Doc3',
      color: PlayerColor.yellow,
      position: dummyLocation,
      asset: '',
      subordinates: [],
    ),
  ];

  // === ПОДЧИНЁННЫЕ ===
  static final List<SubordinateEntity> subordinates = [
    SubordinateEntity(
      id: 1,
      name: 'Doc1Sub1',
      color: PlayerColor.blue,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.key,
    ),
    SubordinateEntity(
      id: 2,
      name: 'Doc1Sub2',
      color: PlayerColor.blue,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.coin,
    ),
    SubordinateEntity(
      id: 3,
      name: 'Doc1Sub3',
      color: PlayerColor.blue,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.letter,
    ),
    SubordinateEntity(
      id: 4,
      name: 'Doc2Sub1',
      color: PlayerColor.red,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.key,
    ),
    SubordinateEntity(
      id: 5,
      name: 'Doc2Sub2',
      color: PlayerColor.red,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.coin,
    ),
    SubordinateEntity(
      id: 6,
      name: 'Doc2Sub3',
      color: PlayerColor.red,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.letter,
    ),SubordinateEntity(
      id: 7,
      name: 'Doc3Sub1',
      color: PlayerColor.yellow,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.key,
    ),
    SubordinateEntity(
      id: 8,
      name: 'Doc3Sub2',
      color: PlayerColor.yellow,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.coin,
    ),
    SubordinateEntity(
      id: 9,
      name: 'Doc3Sub3',
      color: PlayerColor.yellow,
      position: dummyLocation,
      asset: '',
      resourceType: ResourceType.letter,
    ),
  ];

  // === ЧУМА ===
  static final PlagueEntity plague = PlagueEntity(
    id: 1,
    position: dummyLocation,
    targets: [],
  );

  // === МИССИИ ===
  static final List<MissionModel> missions = [
    MissionModel(
      id: 1,
      asset: 'lib/core/assets/task14.jpg',
      effectType: MissionEffectType.continuous,
      resourceCost: {},
      isCompleted: false,
      locationView: const LocationViewModel(xPercent: 60, yPercent: 18),
    ),
  ];

  // === ШТАММЫ ===
  static final List<StrainEntity> strains = [
    StrainEntity(
        id: 1,
        asset: 'lib/core/assets/strains/a.png',
        type: StrainType.harmful,
        position: dummyLocation
    ),
  ];

  // === РЕЦЕПТЫ ===
  static final List<RecipeEntity> recipes = [
    RecipeEntity(
      id: 1,
      asset: 'lib/core/assets/recipes/herbal.png',
      type: RecipeType.action,
      effect: '',
    ),

  ];
}