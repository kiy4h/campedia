import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class CheckoutProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  int? _transactionId;
  String? _transactionMessage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get transactionId => _transactionId;
  String? get transactionMessage => _transactionMessage;

  // Transaction data storage
  int? _storedTransactionId;
  int? _storedTotalAmount;
  String? _storedPickupDate;
  String? _storedReturnDate;
  int? _storedRentalDays;

  // Getters for stored transaction data
  int? get storedTransactionId => _storedTransactionId;
  int? get storedTotalAmount => _storedTotalAmount;
  String? get storedPickupDate => _storedPickupDate;
  String? get storedReturnDate => _storedReturnDate;
  int? get storedRentalDays => _storedRentalDays;

  /// Create a transaction from the current cart
  Future<bool> createTransaction({
    required int userId,
    required int cabangPengambilanId,
    required String tanggalPengambilan,
    required String tanggalPengembalian,
  }) async {
    _isLoading = true;
    _error = null;
    _transactionId = null;
    _transactionMessage = null;
    notifyListeners();

    try {
      final transactionRequest = TransactionRequest(
        userId: userId,
        cabangPengambilanId: cabangPengambilanId,
        tanggalPengambilan: tanggalPengambilan,
        tanggalPengembalian: tanggalPengembalian,
        statusTransaksi: 'Belum Dibayar',
      );

      final response = await ApiService.createTransaction(transactionRequest);

      if (response.success && response.data != null) {
        _transactionId = response.data!['transaksi_id'];
        _transactionMessage = response.message;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to create transaction';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Process payment for a transaction
  Future<bool> processPayment({
    required int transaksiId,
    required String metodePembayaran,
    required int totalPembayaran,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final paymentRequest = PaymentRequest(
        transaksiId: transaksiId,
        metodePembayaran: metodePembayaran,
        tipePembayaran: 'Checkout',
        totalPembayaran: totalPembayaran,
      );

      final response = await ApiService.createPayment(paymentRequest);

      if (response.success) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to process payment';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Reset checkout state
  void reset() {
    _isLoading = false;
    _error = null;
    _transactionId = null;
    _transactionMessage = null;
    notifyListeners();
  }

  /// Store transaction data for use in checkout flow
  void setTransactionData({
    required int transactionId,
    required int totalAmount,
    required String pickupDate,
    required String returnDate,
    required int rentalDays,
  }) {
    _storedTransactionId = transactionId;
    _storedTotalAmount = totalAmount;
    _storedPickupDate = pickupDate;
    _storedReturnDate = returnDate;
    _storedRentalDays = rentalDays;
    notifyListeners();
  }
}
