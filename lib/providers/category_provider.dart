import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _service =
      CategoryService();

  bool _loading = false;

  String? _error;

  List<CategoryModel> _categories = [];

  bool get loading => _loading;

  String? get error => _error;

  List<CategoryModel> get categories =>
      _categories;

  Future<void> getCategories() async {
    try {
      _loading = true;

      notifyListeners();

      _categories =
          await _service.getCategories();

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _loading = false;

    notifyListeners();
  }
}