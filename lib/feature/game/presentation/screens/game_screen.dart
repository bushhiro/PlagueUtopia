import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mor_utopia/feature/game/data/datasources/static_game_data.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/subordinate_entity.dart';
import '../blocs/game_bloc/game_bloc.dart';
import '../blocs/game_bloc/game_event.dart';
import '../blocs/game_bloc/game_state.dart';
import '../widgets/game_control_panel.dart';
import '../widgets/game_map_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  DoctorEntity? selectedDoctor;
  SubordinateEntity? selectedSubordinate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(InitializeGame()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Plague: Utopia'),
          centerTitle: true,
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {

            return Column(
              children: [
                /// Карта с миссиями
                Expanded(
                  flex: 3,
                  child: GameMapWidget(
                    doctors: state.doctors,
                    subordinates: state.subordinates,
                    plague: state.plague,
                    missions: StaticGameData.missions,
                  ),
                ),

                /// Нижняя панель управления ходом
                Expanded(
                  flex: 1,
                  child: const GameControlPanel(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}