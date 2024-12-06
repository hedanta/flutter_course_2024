import 'package:flutter/material.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/note_screen.dart';
import '../../presentation/cubit/note_state.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/note':
        final note = settings.arguments as Note?;
        return MaterialPageRoute(
          builder: (_) => NoteScreen(note: note),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
