import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../cubit/note_cubit.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = Provider.of<NoteCubit>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: const Color(0xffd9d498)),
      body: BlocBuilder<NoteCubit, NoteState>(
        bloc: noteCubit,
        builder: (context, state) {
          if (state.notes.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }

          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteScreen(note: note),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
