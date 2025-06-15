import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'api_config.dart';

class ApiService {
  // Login user
  static Future<ApiResponse<UserData>> login(
      String email, String password) async {
    try {
      final loginRequest = LoginRequest(email: email, password: password);

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.login}'),
        headers: ApiConfig.headers,
        body: jsonEncode(loginRequest.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(responseData);
        return ApiResponse.success(authResponse.data!, authResponse.message);
      } else {
        return ApiResponse.error(responseData['detail'] ?? 'Login failed');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Register user
  static Future<ApiResponse<String>> register(
      String nama, String email, String password) async {
    try {
      final registerRequest =
          RegisterRequest(nama: nama, email: email, password: password);

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.register}'),
        headers: ApiConfig.headers,
        body: jsonEncode(registerRequest.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get top rated items for home page
  static Future<ApiResponse<List<Barang>>> getBarangBeranda(int userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConfig.baseUrl}${ApiConfig.barangBeranda}?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseMap = jsonDecode(response.body);
        final List<dynamic> responseData = responseMap['data'];
        final List<Barang> barangList =
            responseData.map((json) => Barang.fromJson(json)).toList();
        return ApiResponse.success(barangList, 'Data loaded successfully');
      } else {
        final responseData = jsonDecode(response.body);
        return ApiResponse.error(
            responseData['detail'] ?? 'Failed to load data');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get all items
  static Future<ApiResponse<List<Barang>>> getAllBarang(int userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConfig.baseUrl}${ApiConfig.semuaBarang}?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseMap = jsonDecode(response.body);
        final List<dynamic> responseData = responseMap['data'];
        final List<Barang> barangList =
            responseData.map((json) => Barang.fromJson(json)).toList();
        return ApiResponse.success(barangList, 'Data loaded successfully');
      } else {
        final responseData = jsonDecode(response.body);
        return ApiResponse.error(
            responseData['detail'] ?? 'Failed to load data');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Add to wishlist
  static Future<ApiResponse<String>> addToWishlist(
      int userId, int barangId) async {
    try {
      final requestData = {
        'user_id': userId,
        'barang_id': barangId,
      };

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.wishlistInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to add to wishlist');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Add to cart
  static Future<ApiResponse<String>> addToCart(
      int userId, List<Map<String, dynamic>> items) async {
    try {
      final requestData = {
        'user_id': userId,
        'items': items,
      };

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.addToCart}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to add to cart');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Create transaction
  static Future<ApiResponse<Map<String, dynamic>>> createTransaction(
      Map<String, dynamic> transactionData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.transaksiInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(transactionData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(responseData, responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to create transaction');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Create payment
  static Future<ApiResponse<String>> createPayment(
      Map<String, dynamic> paymentData) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.pembayaranInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(paymentData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to create payment');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
}
