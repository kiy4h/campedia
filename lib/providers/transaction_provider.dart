import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class TransactionProvider with ChangeNotifier {
  List<UserTransaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  List<UserTransaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get transactions by status filter
  List<UserTransaction> getTransactionsByStatus(String? statusFilter) {
    if (statusFilter == null || statusFilter == 'Semua Status') {
      return _transactions;
    }
    return _transactions
        .where((transaction) =>
            transaction.statusTransaksi.toLowerCase() ==
            statusFilter.toLowerCase())
        .toList();
  } // Get ongoing/active transactions (transactions that are not completed)

  List<UserTransaction> get ongoingTransactions {
    return _transactions.where((transaction) {
      final status = transaction.statusTransaksi;
      return status == 'Belum Dibayar' ||
          status == 'Belum Diambil' ||
          status == 'Belum Dikembalikan';
    }).toList();
  }

  // Get completed transactions (returned items)
  List<UserTransaction> get completedTransactions {
    return _transactions.where((transaction) {
      final status = transaction.statusTransaksi;
      return status == 'Sudah Dikembalikan';
    }).toList();
  }

  // Load transactions from API
  Future<void> loadTransactions(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getUserTransactions(userId);

      if (response.success && response.data != null) {
        _transactions = response.data!;
        _isLoading = false;
        notifyListeners();
      } else {
        _error = response.error ?? 'Failed to load transactions';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh transactions
  Future<void> refreshTransactions(int userId) async {
    await loadTransactions(userId);
  }

  // Clear transactions (local only)
  void clearTransactions() {
    _transactions.clear();
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
