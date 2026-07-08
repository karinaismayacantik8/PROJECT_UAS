import '../core/constants/api_constants.dart';
import '../models/category_model.dart';
import 'api_service.dart';

class CategoryService {
  final ApiService _api = ApiService();

  Future<List<CategoryModel>> getCategories() async {
    final response =
        await _api.get(ApiConstants.categories);

    final List data = response["data"];

    return data
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}