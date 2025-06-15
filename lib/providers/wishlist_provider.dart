import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class WishlistProvider with ChangeNotifier {
  List<Barang> _wishlistItems = [];
  bool _isLoading = false;
  String? _error;

  List<Barang> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _wishlistItems.length;

  // Load wishlist from API
  Future<void> loadWishlist(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getWishlist(userId);

      if (response.success && response.data != null) {
        _wishlistItems = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load wishlist';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add item to wishlist
  Future<bool> addToWishlist(int userId, int barangId) async {
    try {
      final response = await ApiService.addToWishlist(userId, barangId);

      if (response.success) {
        // Reload wishlist to reflect changes
        await loadWishlist(userId);
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

  // Remove item from wishlist
  Future<bool> removeFromWishlist(int userId, int barangId) async {
    try {
      final response = await ApiService.removeFromWishlist(userId, barangId);

      if (response.success) {
        // Remove item locally and reload from server
        _wishlistItems.removeWhere((item) => item.id == barangId);
        notifyListeners();
        await loadWishlist(userId);
        return true;
      } else {
        _error = response.error ?? 'Failed to remove from wishlist';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      notifyListeners();
      return false;
    }
  }

  // Check if item is in wishlist
  bool isInWishlist(int barangId) {
    return _wishlistItems.any((item) => item.id == barangId);
  }

  // Toggle wishlist status
  Future<bool> toggleWishlist(int userId, int barangId) async {
    if (isInWishlist(barangId)) {
      return await removeFromWishlist(userId, barangId);
    } else {
      return await addToWishlist(userId, barangId);
    }
  }

  // Clear wishlist (local only)
  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
