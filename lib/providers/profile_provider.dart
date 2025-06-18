import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class ProfileProvider with ChangeNotifier {
  User? _userProfile;
  bool _isLoading = false;
  String? _error;

  User? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch user profile data from API
  Future<void> fetchUserProfile(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getUserProfile(userId);

      if (response.success && response.data != null) {
        _userProfile = response.data;
        _error = null;
      } else {
        _error = response.error ?? 'Failed to load profile';
        _userProfile = null;
      }
    } catch (e) {
      _error = 'Network error: $e';
      _userProfile = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear profile data
  void clearProfile() {
    _userProfile = null;
    _error = null;
    notifyListeners();
  }
}
