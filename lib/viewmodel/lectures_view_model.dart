import 'package:zubair_onward_academy/models/lectures_model.dart';
import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class LecturesViewModel with ChangeNotifier {

  final AuthRepository _lecturesRepo = AuthRepository();

  List<LecturesModel> _lectures = [];
  List<LecturesModel> get lectures => _lectures;

  // Loading initialization for books
  bool _lecturesLoading = false;
  bool get lecturesLoading => _lecturesLoading;

  // Loading for books
  setLecturesLoading(bool value) {
    _lecturesLoading = value;
    notifyListeners();
  }

  Future<void> fetchLectures(String categoryId, BuildContext context) async {
    // Start loading
    setLecturesLoading(true);

    try {

      LecturesResponse response = await _lecturesRepo.fetchLectures(categoryId, context);

      if (response.success ?? false) {

        _lectures = response.payload ?? [];

      }
    } catch (e) {

      debugPrint(e.toString());

    } finally {
      // Stop loading
      setLecturesLoading(false);
    }
  }
}
