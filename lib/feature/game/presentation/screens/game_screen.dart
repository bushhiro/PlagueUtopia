import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game_bloc/game_bloc.dart';
import '../blocs/game_bloc/game_event.dart';
import '../blocs/game_bloc/game_state.dart';
import '../widgets/game_map_widget.dart';
// import '../widgets/player_panel_widget.dart';


class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(InitializeGame()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Mor Utopia'),
          centerTitle: true,
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return Stack(
              children: [
                /// Основная карта
                Positioned.fill(
                  child: GameMapWidget(
                    doctors: state.doctors,
                    subordinates: state.subordinates,
                    plague: state.plague,
                  ),
                ),

                /// Нижняя панель с игроками
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: PlayerPanelWidget(players: state.players),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
