class OrderModel {
  final String id;
  final String status;
  final int totalPrice;
  final String createdAt;
  final String customerName;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.customerName,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"]?.toString() ?? "",
      status: json["status"] ?? "",
      totalPrice: json["total_price"] ?? 0,
      createdAt: json["created_at"] ?? "",
      customerName:
          json["user"]?["name"] ??
          json["customer"]?["name"] ??
          "-",
    );
  }
}