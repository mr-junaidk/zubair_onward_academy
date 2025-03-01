import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:zubair_onward_academy/models/books_model.dart';
import 'package:flutter/material.dart';


class BooksViewModel with ChangeNotifier {

  final AuthRepository _booksRepo = AuthRepository();

  List<BooksModel> _books = [];
  List<BooksModel> get books => _books;

  // Loading initialization for books
  bool _booksLoading = false;
  bool get booksLoading => _booksLoading;

  // Loading for books
  setBooksLoading(bool value) {
    _booksLoading = value;
    notifyListeners();
  }

  Future<void> fetchBooks(String categoryId, BuildContext context) async {
    // Start loading
    setBooksLoading(true);

    try {

      BooksResponse response = await _booksRepo.fetchBooks(categoryId, context);

      if (response.success ?? false) {

        _books = response.payload ?? [];

      }
    } catch (e) {

      debugPrint(e.toString());

    } finally {
      // Stop loading
      setBooksLoading(false);
    }
  }
}
