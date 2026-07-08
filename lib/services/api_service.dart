import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../core/storage/shared_pref_service.dart';

class ApiService {
  /// ==========================
  /// HEADER
  /// ==========================

  Future<Map<String, String>> _headers({
    bool authenticated = false,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (authenticated) {
      final token = await SharedPrefService.getToken();

      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    return headers;
  }

  /// ==========================
  /// GET
  /// ==========================

  Future<dynamic> get(
    String endpoint, {
    bool authenticated = false,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}$endpoint"),
        headers: await _headers(
          authenticated: authenticated,
        ),
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    }
  }

  /// ==========================
  /// POST
  /// ==========================

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool authenticated = false,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}$endpoint"),
        headers: await _headers(
          authenticated: authenticated,
        ),
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    }
  }

  /// ==========================
  /// PUT
  /// ==========================

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool authenticated = true,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("${ApiConstants.baseUrl}$endpoint"),
        headers: await _headers(
          authenticated: authenticated,
        ),
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    }
  }

  /// ==========================
  /// DELETE
  /// ==========================

  Future<dynamic> delete(
    String endpoint, {
    bool authenticated = true,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse("${ApiConstants.baseUrl}$endpoint"),
        headers: await _headers(
          authenticated: authenticated,
        ),
      );

      return _handleResponse(response);
    } on SocketException {
      throw Exception("Tidak ada koneksi internet");
    }
  }

  /// ==========================
  /// HANDLE RESPONSE
  /// ==========================

  dynamic _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return body;

      case 400:
        throw Exception(body["message"] ?? "Bad Request");

      case 401:
        throw Exception(body["message"] ?? "Unauthorized");

      case 403:
        throw Exception(body["message"] ?? "Forbidden");

      case 404:
        throw Exception(body["message"] ?? "Data tidak ditemukan");

      case 500:
        throw Exception(body["message"] ?? "Server Error");

      default:
        throw Exception(
          body["message"] ??
              "Terjadi kesalahan (${response.statusCode})",
        );
    }
  }
}