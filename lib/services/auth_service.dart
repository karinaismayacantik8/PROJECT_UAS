import '../core/constants/api_constants.dart';
import '../core/storage/shared_pref_service.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.post(
      ApiConstants.login,
      {
        "email": email,
        "password": password,
      },
    );

    if (response["access_token"] != null) {
      await SharedPrefService.saveToken(
        response["access_token"],
      );
    }

    return response;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _api.post(
      ApiConstants.register,
      {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    return response;
  }

  Future<UserModel> profile() async {
    final response = await _api.get(
      ApiConstants.profile,
      authenticated: true,
    );

    return UserModel.fromJson(response["data"]);
  }

  Future<void> logout() async {
    await SharedPrefService.removeToken();
  }
}