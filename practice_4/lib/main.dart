import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './presentation/cubit/note_cubit.dart';
import './presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        home: HomeScreen(),
      ),
    );
  }
}
