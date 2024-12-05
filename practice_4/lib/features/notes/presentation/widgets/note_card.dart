import 'package:flutter/material.dart';
import '../../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: () {
          // Навигация к экрану редактирования/просмотра заметки
          Navigator.pushNamed(
            context,
            '/note',
            arguments: note,  // Передаем заметку в качестве аргумента
          );
        },
      ),
    );
  }
}