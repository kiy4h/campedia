import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class GunungProvider with ChangeNotifier {
  List<Gunung> _gunungList = [];
  bool _isLoading = false;
  String? _error;

  List<Gunung> get gunungList => _gunungList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all mountains with their associated items
  Future<void> fetchAllGunung(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getAllGunung(userId);

      if (response.success && response.data != null) {
        _gunungList = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load mountains';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}