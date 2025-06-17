import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class DetailBarangProvider with ChangeNotifier {
  DetailBarang? _detailBarang;
  bool _isLoading = false;
  String? _error;

  DetailBarang? get detailBarang => _detailBarang;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get item detail by ID
  Future<void> fetchDetailBarang(int barangId, int userId) async {
    _isLoading = true;
    _error = null;
    _detailBarang = null;
    notifyListeners();

    try {
      final response = await ApiService.getBarangDetail(barangId, userId);

      if (response.success && response.data != null) {
        _detailBarang = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load item detail';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear detail data
  void clearDetail() {
    _detailBarang = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
