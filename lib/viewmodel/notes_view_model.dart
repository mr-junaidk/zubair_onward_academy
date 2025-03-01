import 'package:zubair_onward_academy/models/notes_model.dart';
import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class NotesViewModel with ChangeNotifier {

  final AuthRepository _notesRepo = AuthRepository();

  List<NotesModel> _notes = [];
  List<NotesModel> get notes => _notes;

  // Loading initialization for books
  bool _notesLoading = false;
  bool get notesLoading => _notesLoading;

  // Loading for books
  setNotesLoading(bool value) {
    _notesLoading = value;
    notifyListeners();
  }

  Future<void> fetchNotes(String categoryId, BuildContext context) async {
    // Start loading
    setNotesLoading(true);

    try {

      NotesResponse response = await _notesRepo.fetchNotes(categoryId, context);

      if (response.success ?? false) {

        _notes = response.payload ?? [];

      }
    } catch (e) {

      debugPrint(e.toString());

    } finally {
      // Stop loading
      setNotesLoading(false);
    }
  }
}
