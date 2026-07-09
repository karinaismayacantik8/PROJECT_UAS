import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();

  bool _loading = false;
  String? _error;

  List<OrderModel> _orders = [];

  bool get loading => _loading;

  String? get error => _error;

  List<OrderModel> get orders => _orders;

  /// ==========================
  /// GET ORDER
  /// ==========================
  Future<void> getOrders() async {
    try {
      _loading = true;
      notifyListeners();

      _orders = await _service.getOrders();

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// ==========================
  /// CHECKOUT
  /// ==========================
  Future<void> checkout({
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      await _service.checkout(
        items: items,
      );
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}