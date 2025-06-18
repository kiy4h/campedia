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
        final message = responseData['message'] ?? 'Registration successful';
        return ApiResponse.success(message, message);
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Registration failed';
        return ApiResponse.error(error);
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

  // Get items with filters, search, and sort
  static Future<ApiResponse<List<Barang>>> getBarangWithFilter({
    required int userId,
    List<int>? categoryIds,
    List<int>? brandIds,
    int? hargaMin,
    int? hargaMax,
    double? minRating,
    String? keyword,
    String? sortBy,
    String? order,
  }) async {
    try {
      // Build query parameters
      List<String> queryParts = ['user_id=$userId'];

      if (categoryIds != null && categoryIds.isNotEmpty) {
        for (int categoryId in categoryIds) {
          queryParts.add('kategori_id=$categoryId');
        }
      }

      if (brandIds != null && brandIds.isNotEmpty) {
        for (int brandId in brandIds) {
          queryParts.add('brand_id=$brandId');
        }
      }

      if (hargaMin != null) {
        queryParts.add('harga_min=$hargaMin');
      }

      if (hargaMax != null) {
        queryParts.add('harga_max=$hargaMax');
      }

      if (minRating != null) {
        queryParts.add('min_rating=$minRating');
      }

      if (keyword != null && keyword.isNotEmpty) {
        queryParts.add('keyword=${Uri.encodeComponent(keyword)}');
      }

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParts.add('sort_by=$sortBy');
      }

      if (order != null && order.isNotEmpty) {
        queryParts.add('order=$order');
      }

      // Build final URL
      final url =
          '${ApiConfig.baseUrl}${ApiConfig.semuaBarang}?${queryParts.join('&')}';
      final response =
          await http.get(Uri.parse(url), headers: ApiConfig.headers);

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
      final requestData = WishlistRequest(
        userId: userId,
        barangId: barangId,
      );

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.wishlistInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData.toJson()),
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
      int userId, List<AddToCartItem> items) async {
    try {
      final requestData = AddToCartRequest(
        userId: userId,
        items: items,
      );

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.addToCart}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData.toJson()),
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
      TransactionRequest transactionRequest) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.transaksiInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(transactionRequest.toJson()),
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
      PaymentRequest paymentRequest) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.pembayaranInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(paymentRequest.toJson()),
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

  // Search items
  static Future<ApiResponse<List<Barang>>> searchBarang(
      int userId, String keyword) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConfig.baseUrl}${ApiConfig.semuaBarang}?user_id=$userId&keyword=$keyword'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final List<dynamic> dataList = responseData['data'];
          final List<Barang> barangList =
              dataList.map((json) => Barang.fromJson(json)).toList();
          return ApiResponse.success(
              barangList, 'Search completed successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to search items';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  } // Get item detail

  static Future<ApiResponse<DetailBarang>> getBarangDetail(
      int barangId, int userId) async {
    try {
      final url =
          '${ApiConfig.baseUrl}${ApiConfig.barangDetail}?barang_id=$barangId&user_id=$userId';
      // print('Requesting URL: $url'); // Debug log

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.headers,
      );

      // print('Response status: ${response.statusCode}'); // Debug log
      // print('Response body: ${response.body}'); // Debug log

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          // Extract the nested data structure from FastAPI response
          final data = responseData['data'];
          final barangData = data['barang'];
          final reviewList = data['review'] ?? [];

          // Merge barang data with additional fields for DetailBarang
          final mergedData = Map<String, dynamic>.from(barangData);
          mergedData['reviews'] =
              reviewList; // Map 'review' to 'reviews' for model

          // Handle foto field properly - it might be a list or a single string
          if (barangData['foto'] is List) {
            mergedData['foto'] = barangData['foto'];
          }

          // print('Merged data: $mergedData'); // Debug log

          final DetailBarang barang = DetailBarang.fromJson(mergedData);
          return ApiResponse.success(barang, 'Item detail loaded successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load item detail';
        return ApiResponse.error(error);
      }
    } catch (e) {
      // print('Error in getBarangDetail: $e'); // Debug log
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get wishlist
  static Future<ApiResponse<List<Barang>>> getWishlist(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.wishlist}?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final List<dynamic> dataList = responseData['data'];
          final List<Barang> barangList =
              dataList.map((json) => Barang.fromJson(json)).toList();
          return ApiResponse.success(
              barangList, 'Wishlist loaded successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load wishlist';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Remove from wishlist
  static Future<ApiResponse<String>> removeFromWishlist(
      int userId, int barangId) async {
    try {
      final requestData = {
        'user_id': userId,
        'barang_id': barangId,
      };

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.removeWishlist}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to remove from wishlist');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get cart items
  static Future<ApiResponse<Cart>> getCart(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.keranjang}?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final Cart cart = Cart.fromJson(responseData['data']);
          return ApiResponse.success(cart, 'Cart loaded successfully');
        } else {
          // Empty cart case
          final emptyCart = Cart(id: 0, items: []);
          return ApiResponse.success(
              emptyCart, responseData['message'] ?? 'Cart is empty');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load cart';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Edit cart item quantity
  static Future<ApiResponse<String>> editCartItem(
      int userId, int itemKeranjangId, int kuantitasBaru) async {
    try {
      final requestData = {
        'user_id': userId,
        'item_keranjang_id': itemKeranjangId,
        'kuantitas_baru': kuantitasBaru,
      };

      final response = await http.patch(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.editCartItem}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to edit cart item');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Remove cart item
  static Future<ApiResponse<String>> removeCartItem(
      int userId, int itemKeranjangId) async {
    try {
      final requestData = {
        'user_id': userId,
        'item_keranjang_id': itemKeranjangId,
      };

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.removeCartItem}'),
        headers: ApiConfig.headers,
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to remove cart item');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get transaction detail
  static Future<ApiResponse<TransactionDetail>> getTransactionDetail(
      int transaksiId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConfig.baseUrl}${ApiConfig.transaksiDetail}?transaksi_id=$transaksiId'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final TransactionDetail transactionDetail =
              TransactionDetail.fromJson(responseData['data']);
          return ApiResponse.success(
              transactionDetail, 'Transaction detail loaded successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load transaction detail';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Add review
  static Future<ApiResponse<String>> addReview(
      ReviewRequest reviewRequest) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.reviewInput}'),
        headers: ApiConfig.headers,
        body: jsonEncode(reviewRequest.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse.success(
            responseData['message'], responseData['message']);
      } else {
        return ApiResponse.error(
            responseData['error'] ?? 'Failed to add review');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Filter barang with advanced options
  static Future<ApiResponse<List<Barang>>> filterBarang({
    required int userId,
    List<int>? kategoriId,
    List<int>? brandId,
    int? hargaMin,
    int? hargaMax,
    double? minRating,
    String? sortBy,
    String? order,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/semua_barang/filter');
      final queryParams = <String, dynamic>{
        'user_id': userId.toString(),
      };

      if (kategoriId != null && kategoriId.isNotEmpty) {
        for (int i = 0; i < kategoriId.length; i++) {
          queryParams['kategori_id'] =
              kategoriId.map((id) => id.toString()).toList();
        }
      }

      if (brandId != null && brandId.isNotEmpty) {
        for (int i = 0; i < brandId.length; i++) {
          queryParams['brand_id'] = brandId.map((id) => id.toString()).toList();
        }
      }

      if (hargaMin != null) queryParams['harga_min'] = hargaMin.toString();
      if (hargaMax != null) queryParams['harga_max'] = hargaMax.toString();
      if (minRating != null) queryParams['min_rating'] = minRating.toString();
      if (sortBy != null) queryParams['sort_by'] = sortBy;
      if (order != null) queryParams['order'] = order;

      final finalUri = uri.replace(queryParameters: queryParams);

      final response = await http.get(
        finalUri,
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final List<dynamic> dataList = responseData['data'];
          final List<Barang> barangList =
              dataList.map((json) => Barang.fromJson(json)).toList();
          return ApiResponse.success(barangList, 'Items filtered successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to filter items';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get user transactions
  static Future<ApiResponse<List<UserTransaction>>> getUserTransactions(
      int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.transaksi}?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final List<dynamic> dataList = responseData['data'];
          final List<UserTransaction> transactions =
              dataList.map((json) => UserTransaction.fromJson(json)).toList();
          return ApiResponse.success(
              transactions, 'Transactions loaded successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load transactions';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  // Get user profile
  static Future<ApiResponse<User>> getUserProfile(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/user/profile?user_id=$userId'),
        headers: ApiConfig.headers,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['data'] != null) {
          final User user = User.fromJson(responseData['data']);
          return ApiResponse.success(
              user, responseData['message'] ?? 'Profile loaded successfully');
        } else {
          return ApiResponse.error('No data found in response');
        }
      } else {
        final error = responseData['error'] ??
            responseData['detail'] ??
            'Failed to load user profile';
        return ApiResponse.error(error);
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
}
