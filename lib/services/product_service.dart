import '../core/constants/api_constants.dart';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _apiService = ApiService();

  /// ==========================
  /// GET LIST PRODUCT
  /// ==========================

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? sort,
  }) async {
    String endpoint =
        "${ApiConstants.products}?page=$page&limit=$limit";

    if (search != null && search.isNotEmpty) {
      endpoint += "&search=$search";
    }

    if (category != null && category.isNotEmpty) {
      endpoint += "&category=$category";
    }

    if (sort != null && sort.isNotEmpty) {
      endpoint += "&sort=$sort";
    }

    final response = await _apiService.get(endpoint);

    final List products = response["data"];

    return products
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  /// ==========================
  /// GET DETAIL PRODUCT
  /// ==========================

  Future<ProductModel> getProductDetail(
    String id,
  ) async {
    final response = await _apiService.get(
      "${ApiConstants.products}/$id",
    );

    return ProductModel.fromJson(
      response["data"],
    );
  }

  /// ==========================
  /// CREATE PRODUCT
  /// ==========================

  Future<void> createProduct({
    required String name,
    required String description,
    required int price,
    required int stock,
    required String categoryId,
    required String imageUrl,
  }) async {
    await _apiService.post(
      ApiConstants.products,
      {
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category_id": categoryId,
        "image_url": imageUrl,
      },
      authenticated: true,
    );
  }

  /// ==========================
  /// UPDATE PRODUCT
  /// ==========================

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
    await _apiService.put(
      "${ApiConstants.products}/$id",
      {
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category_id": categoryId,
        "image_url": imageUrl,
        "is_active": isActive,
      },
      authenticated: true,
    );
  }

  /// ==========================
  /// DELETE PRODUCT
  /// ==========================

  Future<void> deleteProduct(
    String id,
  ) async {
    await _apiService.delete(
      "${ApiConstants.products}/$id",
      authenticated: true,
    );
  }
}