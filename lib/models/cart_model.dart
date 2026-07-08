import 'product_model.dart';

class CartModel {
  final String id;
  final int quantity;
  final ProductModel product;

  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"] ?? "",
      quantity: json["quantity"] ?? 1,
      product: ProductModel.fromJson(
        json["product"] ?? {},
      ),
    );
  }
}