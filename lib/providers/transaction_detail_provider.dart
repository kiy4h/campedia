import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class TransactionDetailProvider with ChangeNotifier {
  TransactionDetail? _transactionDetail;
  bool _isLoading = false;
  String? _error;

  TransactionDetail? get transactionDetail => _transactionDetail;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load transaction detail from API
  Future<void> loadTransactionDetail(int transaksiId) async {
    _isLoading = true;
    _error = null;
    _transactionDetail = null;
    notifyListeners();

    try {
      final response = await ApiService.getTransactionDetail(transaksiId);

      if (response.success && response.data != null) {
        _transactionDetail = response.data;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load transaction detail';
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

  // Clear data
  void clear() {
    _transactionDetail = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
