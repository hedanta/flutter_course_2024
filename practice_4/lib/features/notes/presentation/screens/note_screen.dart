import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../cubit/note_cubit.dart';
import '../../models/note.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  void _saveNote() {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isNotEmpty) {
      final noteCubit = context.read<NoteCubit>();

      if (widget.note == null) {
        // Add a new note
        noteCubit.addNote(title, content);
      } else {
        // Update the existing note
        noteCubit.updateNote(widget.note!.id, title, content);
      }
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to delete this note? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<NoteCubit>().deleteNote(widget.note!.id);
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        _saveNote();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
          actions: [
            if (widget.note != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the title',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  hintText: 'Enter the content',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}