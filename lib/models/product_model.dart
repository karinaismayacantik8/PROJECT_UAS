import 'category_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final int price;
  final int stock;
  final String categoryId;
  final String imageUrl;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final CategoryModel? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      categoryId: json['category_id'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      category: json['categories'] != null
          ? CategoryModel.fromJson(json['categories'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "price": price,
      "stock": stock,
      "category_id": categoryId,
      "image_url": imageUrl,
      "is_active": isActive,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "categories": category?.toJson(),
    };
  }
}