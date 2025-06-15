import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;
  bool _isLoading = false;
  String? _error;

  Cart? get cart => _cart;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _cart?.items.length ?? 0;

  // Calculate total price
  int get totalPrice {
    if (_cart == null) return 0;
    return _cart!.items.fold(0, (sum, item) => sum + item.subtotal);
  }

  // Load cart from API
  Future<void> loadCart(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getCart(userId);

      if (response.success && response.data != null) {
        _cart = response.data;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load cart';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add item to cart
  Future<bool> addToCart(int userId, int barangId, int quantity) async {
    try {
      final items = [AddToCartItem(barangId: barangId, kuantitas: quantity)];
      final response = await ApiService.addToCart(userId, items);

      if (response.success) {
        // Reload cart to reflect changes
        await loadCart(userId);
        return true;
      } else {
        _error = response.error ?? 'Failed to add to cart';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      notifyListeners();
      return false;
    }
  }

  // Update item quantity
  Future<bool> updateItemQuantity(
      int userId, int itemKeranjangId, int newQuantity) async {
    try {
      final response =
          await ApiService.editCartItem(userId, itemKeranjangId, newQuantity);

      if (response.success) {
        // Reload cart to reflect changes
        await loadCart(userId);
        return true;
      } else {
        _error = response.error ?? 'Failed to update item quantity';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      notifyListeners();
      return false;
    }
  }

  // Remove item from cart
  Future<bool> removeItem(int userId, int itemKeranjangId) async {
    try {
      final response = await ApiService.removeCartItem(userId, itemKeranjangId);

      if (response.success) {
        // Reload cart to reflect changes
        await loadCart(userId);
        return true;
      } else {
        _error = response.error ?? 'Failed to remove item';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      notifyListeners();
      return false;
    }
  }

  // Clear cart (local only)
  void clearCart() {
    _cart = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
