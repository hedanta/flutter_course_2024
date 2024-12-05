import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './features/notes/cubit/note_cubit.dart';
import './features/notes/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NoteCubit>(
          create: (_) => NoteCubit(),
          dispose: (_, cubit) => cubit.close(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        home: HomeScreen(),
      ),
    );
  }
}
