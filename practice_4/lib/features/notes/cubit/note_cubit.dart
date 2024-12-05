import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note.dart';

class NoteState {
  final List<Note> notes;
  const NoteState({this.notes = const []});
}

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(const NoteState());

  void addNote(String title, String content) {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
    );
    emit(NoteState(notes: List.from(state.notes)..add(newNote)));
  }

  void updateNote(String id, String newTitle, String newContent) {
    final updatedNotes = state.notes.map((note) {
      if (note.id == id) {
        return note.copyWith(title: newTitle, content: newContent);
      }
      return note;
    }).toList();
    emit(NoteState(notes: updatedNotes));
  }

  void deleteNote(String id) {
    final updatedNotes = state.notes.where((note) => note.id != id).toList();
    emit(NoteState(notes: updatedNotes));
  }

  void loadNotes(List<Note> initialNotes) {
    emit(NoteState(notes: initialNotes));
  }
}
