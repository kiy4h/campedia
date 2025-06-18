import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class BarangProvider with ChangeNotifier {
  List<Barang> _barangBeranda = [];
  List<Barang> _allBarang = [];
  bool _isLoading = false;
  String? _error;

  List<Barang> get barangBeranda => _barangBeranda;
  List<Barang> get allBarang => _allBarang;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get featured items for homepage
  Future<void> fetchBarangBeranda(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getBarangBeranda(userId);

      if (response.success && response.data != null) {
        _barangBeranda = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load featured items';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get all items
  Future<void> fetchAllBarang(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getAllBarang(userId);

      if (response.success && response.data != null) {
        _allBarang = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load items';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get all items with filters, search, and sort
  Future<void> fetchBarangWithFilter({
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
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getBarangWithFilter(
        userId: userId,
        categoryIds: categoryIds,
        brandIds: brandIds,
        hargaMin: hargaMin,
        hargaMax: hargaMax,
        minRating: minRating,
        keyword: keyword,
        sortBy: sortBy,
        order: order,
      );

      if (response.success && response.data != null) {
        _allBarang = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load items';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add to wishlist
  Future<bool> addToWishlist(int userId, int barangId) async {
    try {
      final response = await ApiService.addToWishlist(userId, barangId);

      if (response.success) {
        // Update the wishlist status locally
        _updateWishlistStatus(barangId, true);
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to add to wishlist';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      notifyListeners();
      return false;
    }
  }

  // Update wishlist status locally
  void _updateWishlistStatus(int barangId, bool isWishlist) {
    // Update in barangBeranda list
    for (int i = 0; i < _barangBeranda.length; i++) {
      if (_barangBeranda[i].id == barangId) {
        _barangBeranda[i] = Barang(
          id: _barangBeranda[i].id,
          namaBarang: _barangBeranda[i].namaBarang,
          kategoriId: _barangBeranda[i].kategoriId,
          brandId: _barangBeranda[i].brandId,
          stok: _barangBeranda[i].stok,
          hargaPerhari: _barangBeranda[i].hargaPerhari,
          deskripsi: _barangBeranda[i].deskripsi,
          meanReview: _barangBeranda[i].meanReview,
          totalReview: _barangBeranda[i].totalReview,
          statusBarang: _barangBeranda[i].statusBarang,
          tanggalDitambahkan: _barangBeranda[i].tanggalDitambahkan,
          foto: _barangBeranda[i].foto,
          isWishlist: isWishlist,
        );
        break;
      }
    }

    // Update in allBarang list
    for (int i = 0; i < _allBarang.length; i++) {
      if (_allBarang[i].id == barangId) {
        _allBarang[i] = Barang(
          id: _allBarang[i].id,
          namaBarang: _allBarang[i].namaBarang,
          kategoriId: _allBarang[i].kategoriId,
          brandId: _allBarang[i].brandId,
          stok: _allBarang[i].stok,
          hargaPerhari: _allBarang[i].hargaPerhari,
          deskripsi: _allBarang[i].deskripsi,
          meanReview: _allBarang[i].meanReview,
          totalReview: _allBarang[i].totalReview,
          statusBarang: _allBarang[i].statusBarang,
          tanggalDitambahkan: _allBarang[i].tanggalDitambahkan,
          foto: _allBarang[i].foto,
          isWishlist: isWishlist,
        );
        break;
      }
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
