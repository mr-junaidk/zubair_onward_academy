import 'package:zubair_onward_academy/repository/auth_repository.dart';
import 'package:zubair_onward_academy/models/category_model.dart';
import 'package:flutter/material.dart';


class CategoryViewModel with ChangeNotifier {

  final AuthRepository _categoryRepo = AuthRepository();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  // Loading initialization for category
  bool _categoryLoading = false;
  bool get categoryLoading => _categoryLoading;

  // Loading for category
  setCategoryLoading(bool value) {
    _categoryLoading = value;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    // Start loading
    setCategoryLoading(true);

    try {

      CategoryResponse response = await _categoryRepo.fetchCategories();

      if (response.success ?? false) {

        _categories = response.payload ?? [];

      }
    } catch (e) {

      debugPrint(e.toString());

    } finally {
      // Stop loading
      setCategoryLoading(false);

    }
  }
}
