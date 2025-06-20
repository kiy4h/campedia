import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  UserData? _user;
  User? _userDetails; // Optional: If you want to keep User details separate
  bool _isLoading = false;
  String? _error;

  UserData? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _loadUserFromStorage();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_data');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        _user = UserData.fromJson(userData);
        notifyListeners();
      }
    } catch (e) {
      // print('Error loading user from storage: $e');
    }
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserToStorage(UserData user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(user.toJson()));
    } catch (e) {
      // print('Error saving user to storage: $e');
    }
  }

  // Clear user data from SharedPreferences
  Future<void> _clearUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
    } catch (e) {
      // print('Error clearing user from storage: $e');
    }
  }

  // Login function
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.login(email, password);

      if (response.success && response.data != null) {
        _user = response.data;
        await _saveUserToStorage(_user!);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Login failed';
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

  // Register function
  Future<bool> register(String nama, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.register(nama, email, password);

      if (response.success) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Registration failed';
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

  // Method untuk update data checkout user
  Future<bool> updateUserCheckoutData({
    required String alamat,
    required String noHp,
    required String kota,
    required String nik,
    required int? boothId,
  }) async {
    if (!isAuthenticated || _user == null) {
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      
      final request = UserCheckoutDataRequest(
        alamat: alamat,
        noHp: noHp,
        kota: kota,
        nik: nik,
        boothId: boothId!,
      );

      final response = await ApiService.updateUserCheckoutData(
        userId: _user!.userId,
        request: request,
      );

      if (response.success && response.data != null) {
        // Update user data locally
        _userDetails = User(
          id: _user!.userId,
          nama: _user!.nama,
          email: _user!.email,
          alamat: alamat,
          noHp: noHp,
          kota: kota,
          nik: nik
        );
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to update user data';
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

  // Method untuk cek apakah user sudah memiliki data checkout lengkap
  bool get hasCompleteCheckoutData {
    return _userDetails?.alamat != null && 
           _userDetails?.noHp != null && 
           _userDetails?.kota != null && 
           _userDetails?.nik != null;
  }

  // Logout function
  Future<void> logout() async {
    _user = null;
    await _clearUserFromStorage();
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
