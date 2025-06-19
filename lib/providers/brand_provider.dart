import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class BrandProvider with ChangeNotifier {
  List<Brand> _brandList = [];
  bool _isLoading = false;
  String? _error;

  List<Brand> get brandList => _brandList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBrand() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getBrand();

      if (response.success && response.data != null) {
        _brandList = response.data!;
        _error = null;
      } else {
        _error = response.error ?? 'Failed to load brands';
        _brandList = [];
      }
    } catch (e) {
      _error = e.toString();
      _brandList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
