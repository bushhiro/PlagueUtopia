import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/static_game_data.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import '../../domain/usecases/move_character.dart';
import '../blocs/game_bloc/game_bloc.dart';
import '../blocs/game_bloc/game_event.dart';
import '../blocs/game_bloc/game_state.dart';

class GameControlPanel extends StatefulWidget {
  const GameControlPanel({Key? key}) : super(key: key);

  @override
  State<GameControlPanel> createState() => _GameControlPanelState();
}

class _GameControlPanelState extends State<GameControlPanel> {
  DoctorEntity? selectedDoctor;
  SubordinateEntity? selectedSubordinate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final activePlayer = state.activePlayer;
        final phase = state.phase;

        // helper: show only subordinates that belong to active player's doctor (if player is doctor)
        final ownSubs = <SubordinateEntity>[];
        if (!activePlayer.isPlague && activePlayer.doctor != null) {
          final doc = activePlayer.doctor!;
          // предполагается, что subordinates у доктора доступен как список сущностей
          ownSubs.addAll(state.subordinates.where((s) => s.color == doc.color));
        }

        return Container(
          color: Colors.grey.shade300,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ход игрока: ${activePlayer.id} (${activePlayer.isPlague ? 'Чума' : activePlayer.doctor?.color.name ?? '—'})'),
              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                children: [
                  if (!activePlayer.isPlague && activePlayer.doctor != null)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedDoctor = activePlayer.doctor;
                          selectedSubordinate = null;
                        });
                      },
                      child: const Text('Выбрать врача'),
                    ),
                  for (final s in ownSubs)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedSubordinate = s;
                          selectedDoctor = null;
                        });
                      },
                      child: Text('Подчинённый #${s.id}'),
                    ),
                  if (activePlayer.isPlague && phase == MovePhase.initialPlacement)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedDoctor = null;
                          selectedSubordinate = null; // сигнализируем, что это ход Чумы
                        });
                      },
                      child: const Text('Выбрать Чуму'),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              const Text('Локации:'),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: StaticGameData.locations.map((loc) {
                  // decide whether button enabled:
                  bool enabled = false;

                  if (phase == MovePhase.initialPlacement) {
                    // enabled если выбран персонаж и он ещё не расставлен (или это чума)
                    if (selectedDoctor != null) {
                      enabled = !state.placedCharacterIds.contains(selectedDoctor!.id);
                    } else if (selectedSubordinate != null) {
                      enabled = !state.placedCharacterIds.contains(selectedSubordinate!.id);
                    } else if (activePlayer.isPlague) {
                      enabled = !state.placedCharacterIds.contains(-1); // Чума ещё не ходила
                    }
                    // и проверяем занятость локации (в initialPlacement локация должна быть свободна, чума — исключение)
                    if (!activePlayer.isPlague && enabled) {
                      // если локация занята другими персонажами — ставить нельзя
                      final occupied = state.doctors.any((d) => d.position.id == loc.id)
                          || state.subordinates.any((s) => s.position.id == loc.id);
                      if (occupied) enabled = false;
                    }
                  } else {
                    // normal phase: enabled если выбран персонаж и правила перехода соблюдаются
                    if (selectedDoctor != null) {
                      enabled = selectedDoctor!.color == activePlayer.doctor?.color;
                      // adjacency и river проверяется при нажатии через MoveCharacter usecase
                    } else if (selectedSubordinate != null) {
                      enabled = true;
                    } else if (activePlayer.isPlague) {
                      enabled = false; // чума в normal — управляется другим UI/логикой
                    }
                  }

                  return ElevatedButton(
                    onPressed: enabled ? () async {
                      // вызываем usecase через BLoC (через событие MoveCharacterEvent)
                      // но для удобства тут можно вызвать usecase напрямую, а затем послать UpdatePlacedCharacters/NextPlayerTurn
                      final useCase = MoveCharacter(
                        doctors: state.doctors,
                        subordinates: state.subordinates,
                        plague: state.plague,
                      );

                      final res = useCase.call(
                        doctor: selectedDoctor,
                        subordinate: selectedSubordinate,
                        newLocation: loc,
                        phase: phase,
                        playerColor: activePlayer.doctor?.color ?? PlayerColor.blue,
                        placedCharacterIds: state.placedCharacterIds,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res.success ? 'Перемещено' : 'Невозможно: ${res.reason ?? ''}')),
                      );

                      print('phase: $phase');
                      print('player ${activePlayer.id}');

                      if (res.success && phase == MovePhase.initialPlacement) {
                        // обновляем пометку расстановки:
                        final updated = List<int>.from(state.placedCharacterIds);
                        if (selectedDoctor != null) {
                          updated.add(selectedDoctor!.id);
                        } else if (selectedSubordinate != null) {
                          updated.add(selectedSubordinate!.id);
                        } else {
                          // это ход чумы
                          updated.add(-1);
                        }
                        context.read<GameBloc>().add(UpdatePlacedCharacters(updated));
                        print('updated $updated');
                        // переходим к следующему игроку
                        context.read<GameBloc>().add(NextPlayerTurn());
                        // сбрасываем выбор
                        setState(() {
                          selectedDoctor = null;
                          selectedSubordinate = null;
                        });
                      } else if (res.success && phase == MovePhase.normal) {
                        // в normal просто обновляем UI (объекты по ссылке уже изменены)
                        setState(() {});
                        // можно также вызвать событие NextPlayerTurn() в зависимости от правил хода
                      }
                    } : null,
                    child: Text('Локация ${loc.id}'),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}