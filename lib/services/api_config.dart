class ApiConfig {
  // Base URL for your FastAPI server
  static const String baseUrl = 'http://127.0.0.1:8000';

  // API Endpoints
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String barangBeranda = '/api/barang_beranda';
  static const String semuaBarang = '/api/semua_barang';
  static const String wishlistInput = '/api/wishlist_input';
  static const String addToCart = '/api/add_to_cart';
  static const String transaksiInput = '/api/transaksi_input';
  static const String pembayaranInput = '/api/pembayaran_input';

  // Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Map<String, String> headersWithAuth(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
