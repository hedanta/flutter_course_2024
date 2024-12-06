import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../cubit/note_cubit.dart';
import '../cubit/note_state.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({super.key, this.note});

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
        noteCubit.addNote(title, content);
      } else {
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
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        _saveNote();
        return;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd9d498),
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the title',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey
                  ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff473f31),
                      ),
                    )
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: 'Enter the content',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff473f31),
                    ),
                  )
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