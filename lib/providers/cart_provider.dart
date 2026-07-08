import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _service = CartService();

  bool _loading = false;
  String? _error;

  List<CartModel> _items = [];

  /// ===========================
  /// GETTER
  /// ===========================

  bool get loading => _loading;

  String? get error => _error;

  List<CartModel> get items => _items;

  /// Jumlah jenis produk
  int get totalItem => _items.length;

  /// Total seluruh quantity
  int get totalQuantity {
    int total = 0;

    for (final item in _items) {
      total += item.quantity;
    }

    return total;
  }

  /// Total harga seluruh produk
  double get grandTotal {
    double total = 0;

    for (final item in _items) {
      total += item.product.price * item.quantity;
    }

    return total;
  }

  /// ===========================
  /// GET CART
  /// ===========================

  Future<void> getCart() async {
    try {
      _loading = true;
      notifyListeners();

      _items = await _service.getCart();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// ===========================
  /// ADD TO CART
  /// ===========================

  Future<void> addToCart({
    required String productId,
    int quantity = 1,
  }) async {
    try {
      await _service.addToCart(
        productId: productId,
        quantity: quantity,
      );

      await getCart();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  /// ===========================
  /// UPDATE QUANTITY
  /// ===========================

  Future<void> updateQuantity({
    required String cartId,
    required int quantity,
  }) async {
    try {
      await _service.updateCart(
        cartId: cartId,
        quantity: quantity,
      );

      await getCart();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// ===========================
  /// REMOVE ITEM
  /// ===========================

  Future<void> removeItem(String cartId) async {
    try {
      await _service.removeItem(cartId);

      await getCart();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// ===========================
  /// CLEAR CART
  /// ===========================

  Future<void> clearCart() async {
    try {
      await _service.clearCart();

      await getCart();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}