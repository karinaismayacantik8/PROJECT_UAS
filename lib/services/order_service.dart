import '../core/constants/api_constants.dart';
import '../models/order_model.dart';
import 'api_service.dart';

class OrderService {
  final ApiService _api = ApiService();

  /// ==========================
  /// GET ALL ORDER
  /// ==========================
  Future<List<OrderModel>> getOrders() async {
    final response = await _api.get(
      ApiConstants.orders,
      authenticated: true,
    );

    final List data = response["data"];

    return data
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  /// ==========================
  /// CREATE ORDER
  /// ==========================
  Future<void> checkout({
    required List<Map<String, dynamic>> items,
  }) async {
    await _api.post(
      ApiConstants.orders,
      {
        "items": items,
      },
      authenticated: true,
    );
  }
}