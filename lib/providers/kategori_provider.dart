import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class KategoriProvider with ChangeNotifier {
  List<Kategori> _kategoriList = [];
  bool _isLoading = false;
  String? _error;

  List<Kategori> get kategoriList => _kategoriList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchKategori() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getKategori();
      
      if (response.success && response.data != null) {
        _kategoriList = response.data!;
        _error = null;
      } else {
        _error = response.error ?? 'Failed to load categories';
        _kategoriList = [];
      }
    } catch (e) {
      _error = e.toString();
      _kategoriList = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}