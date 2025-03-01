import 'package:zubair_onward_academy/models/mcqs_model.dart';
import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class McqsViewModel with ChangeNotifier {

  final AuthRepository _mcqsRepo = AuthRepository();

  List<McqsModel> _mcqs = [];
  List<McqsModel> get mcqs => _mcqs;

  // Loading initialization for books
  bool _mcqsLoading = false;
  bool get mcqsLoading => _mcqsLoading;

  // Loading for books
  setMcqsLoading(bool value) {
    _mcqsLoading = value;
    notifyListeners();
  }

  Future<void> fetchMcqs(String categoryId, BuildContext context) async {
    // Start loading
    setMcqsLoading(true);

    try {

      McqsResponse response = await _mcqsRepo.fetchMcqs(categoryId, context);

      if (response.success ?? false) {

        _mcqs = response.payload ?? [];

      }
    } catch (e) {

      debugPrint(e.toString());

    } finally {
      // Stop loading
      setMcqsLoading(false);
    }
  }
}
