class CategoryModel {
  final String id;
  final String name;
 final String slug;
  final String? description;
  final String? imageUrl;
  final String? createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imageUrl,
    this.createdAt,
  });

  factory CategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CategoryModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      description: json["description"],
      imageUrl: json["image_url"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "image_url": imageUrl,
      "created_at": createdAt,
    };
  }
}