import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/category_service.dart';
import '../services/product_service.dart';

class AdminProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();

  bool _loading = false;
  String? _error;

  List<ProductModel> _products = [];
  List<CategoryModel> _categories = [];

  bool get loading => _loading;
  String? get error => _error;

  List<ProductModel> get products => _products;
  List<CategoryModel> get categories => _categories;

  int get totalProduct => _products.length;
  int get totalCategory => _categories.length;

  /// sementara dummy
  int get totalUser => 0;
  int get totalOrder => 0;

  Future<void> loadDashboard() async {
    try {
      _loading = true;
      notifyListeners();

      _products = await _productService.getProducts(
        page: 1,
        limit: 1000,
      );

      _categories =
          await _categoryService.getCategories();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}