import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note.dart';  // Correct import from models

// Define the states for the NoteCubit
class NoteState {
  final List<Note> notes;
  const NoteState({this.notes = const []});
}

// Define the cubit for managing notes
class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(const NoteState());

  // Add a new note
  void addNote(String title, String content) {
    final newNote = Note(
      id: DateTime.now().toString(),  // Unique ID based on current time
      title: title,
      content: content,
    );
    emit(NoteState(notes: List.from(state.notes)..add(newNote)));
  }

  // Update an existing note
  void updateNote(String id, String newTitle, String newContent) {
    final updatedNotes = state.notes.map((note) {
      if (note.id == id) {
        return note.copyWith(title: newTitle, content: newContent);
      }
      return note;
    }).toList();
    emit(NoteState(notes: updatedNotes));
  }

  // Delete a note
  void deleteNote(String id) {
    final updatedNotes = state.notes.where((note) => note.id != id).toList();
    emit(NoteState(notes: updatedNotes));
  }

  // Load initial notes (this could be fetched from a local database or API)
  void loadNotes(List<Note> initialNotes) {
    emit(NoteState(notes: initialNotes));
  }
}
