import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/note_screen.dart';
import '../models/note.dart';

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
