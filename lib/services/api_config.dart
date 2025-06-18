class ApiConfig {
  // Base URL for your FastAPI server
  static const String baseUrl = 'http://127.0.0.1:8000';

  // API Endpoints
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String barangBeranda = '/api/barang_beranda';
  static const String semuaBarang = '/api/barang/list';
  static const String barangDetail = '/api/barang';
  static const String wishlist = '/api/wishlist';
  static const String wishlistInput = '/api/add_to_wishlist';
  static const String removeWishlist = '/api/remove_wishlist_item';
  static const String keranjang = '/api/keranjang';
  static const String addToCart = '/api/add_to_cart';
  static const String editCartItem = '/api/edit_cart_item';
  static const String removeCartItem = '/api/remove_cart_item';
  static const String transaksiInput = '/api/transaksi_input';
  static const String transaksi = '/api/transaksi';
  static const String transaksiDetail = '/api/transaksi_detail';
  static const String pembayaranInput = '/api/pembayaran_input';
  static const String reviewInput = '/api/review_input';
  static const String notifikasiInput = '/api/notifikasi_input';

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
