import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/game/presentation/blocs/game_bloc/game_event.dart';
import 'feature/game/presentation/screens/game_screen.dart';
import 'feature/game/presentation/blocs/game_bloc/game_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (_) => GameBloc()..add(InitializeGame()),
        ),
        // Здесь можно добавить другие BlocProvider или Provider, если потребуется
      ],
      child: MaterialApp(
        title: 'Plague Utopia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const GameScreen(),
      ),
    );
  }
}