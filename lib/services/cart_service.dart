import '../core/constants/api_constants.dart';
import '../models/cart_model.dart';
import 'api_service.dart';

class CartService {
  final ApiService _apiService = ApiService();

  /// ===========================
  /// GET CART
  /// ===========================
  Future<List<CartModel>> getCart() async {
    final response = await _apiService.get(
      ApiConstants.cart,
      authenticated: true,
    );

    final List data = response["data"];

    return data
        .map((e) => CartModel.fromJson(e))
        .toList();
  }

  /// ===========================
  /// ADD TO CART
  /// ===========================
  Future<void> addToCart({
    required String productId,
    int quantity = 1,
  }) async {
    await _apiService.post(
      ApiConstants.cart,
      {
        "product_id": productId,
        "quantity": quantity,
      },
      authenticated: true,
    );
  }

  /// ===========================
  /// UPDATE CART
  /// ===========================
  Future<void> updateCart({
    required String cartId,
    required int quantity,
  }) async {
    await _apiService.put(
      "${ApiConstants.cart}/$cartId",
      {
        "quantity": quantity,
      },
      authenticated: true,
    );
  }

  /// ===========================
  /// REMOVE ITEM
  /// ===========================
  Future<void> removeItem(String cartId) async {
    await _apiService.delete(
      "${ApiConstants.cart}/$cartId",
      authenticated: true,
    );
  }

  /// ===========================
  /// CLEAR CART
  /// ===========================
  Future<void> clearCart() async {
    await _apiService.delete(
      ApiConstants.cart,
      authenticated: true,
    );
  }
}