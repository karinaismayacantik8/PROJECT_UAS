import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  bool _loading = false;
  String? _error;

  List<ProductModel> _products = [];

  String _search = "";

  int _page = 1;
  final int _limit = 10;

  // ==========================
  // GETTER
  // ==========================

  bool get loading => _loading;

  String? get error => _error;

  List<ProductModel> get products => _products;

  String get search => _search;

  int get page => _page;

  int get limit => _limit;

  // ==========================
  // GET PRODUCT
  // ==========================

  Future<void> getProducts({
    String search = "",
    bool refresh = false,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      if (refresh) {
        _page = 1;
        _products.clear();
      }

      _search = search;

      final result = await _service.getProducts(
        page: _page,
        limit: _limit,
        search: search,
      );

      if (_page == 1) {
        _products = result;
      } else {
        _products.addAll(result);
      }

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ==========================
  // LOAD MORE
  // ==========================

  Future<void> loadMore() async {
    _page++;

    await getProducts(
      search: _search,
    );
  }

  // ==========================
  // REFRESH PRODUCT
  // ==========================

  Future<void> refreshProducts() async {
    await getProducts(
      search: _search,
      refresh: true,
    );
  }

  // ==========================
  // CREATE PRODUCT
  // ==========================

  Future<void> createProduct({
    required String name,
    required String description,
    required int price,
    required int stock,
    required String categoryId,
    required String imageUrl,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      await _service.createProduct(
        name: name,
        description: description,
        price: price,
        stock: stock,
        categoryId: categoryId,
        imageUrl: imageUrl,
      );

      await refreshProducts();

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ==========================
  // UPDATE PRODUCT
  // ==========================

  Future<void> updateProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int stock,
    required String categoryId,
    required String imageUrl,
    bool isActive = true,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      await _service.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        stock: stock,
        categoryId: categoryId,
        imageUrl: imageUrl,
        isActive: isActive,
      );

      await refreshProducts();

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // ==========================
  // DELETE PRODUCT
  // ==========================

  Future<void> deleteProduct(String id) async {
    try {
      _loading = true;
      notifyListeners();

      await _service.deleteProduct(id);

      await refreshProducts();

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}