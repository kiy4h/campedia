class User {
  final int id;
  final String nama;
  final String email;
  final String? alamat;
  final String? noHp;
  final String? kota;
  final String? nik; // akan disimpan dalam bentuk terenkripsi
  final String? gambar; // akan disimpan dalam bentuk terenkripsi

  User({
    required this.id,
    required this.nama,
    required this.email,
    this.alamat,
    this.noHp,
    this.kota,
    this.nik,
    this.gambar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      kota: json['kota'],
      nik: json['nik'],
      gambar: json['gambar'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'username': nama,
      'email': email,
      'alamat': alamat,
      'no_hp': noHp,
      'kota': kota,
      'nik': nik,
      'gambar': gambar,
    };
  }
}

class Brand {
  final int id;
  final String namaBrand;
  final int totalBarang;

  Brand({
    required this.id,
    required this.namaBrand,
    required this.totalBarang,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? 0,
      namaBrand: json['nama_brand'] ?? '',
      totalBarang: json['total_barang'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_brand': namaBrand,
      'total_barang': totalBarang,
    };
  }
}

class Kategori {
  final int id;
  final String namaKategori;
  final String? icon;
  final int totalBarang;

  Kategori({
    required this.id,
    required this.namaKategori,
    this.icon,
    required this.totalBarang,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'] ?? 0,
      namaKategori: json['nama_kategori'] ?? '',
      icon: json['icon'],
      totalBarang: json['total_barang'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
      'icon': icon,
      'total_barang': totalBarang,
    };
  }
}

// Model untuk update data checkout user
class UserCheckoutDataRequest {
  final String alamat;
  final String noHp;
  final String kota;
  final String nik;
  final int? boothId; // Tambahkan field boothId jika diperlukan

  UserCheckoutDataRequest({
    required this.alamat,
    required this.noHp,
    required this.kota,
    required this.nik,
    required this.boothId,
  });

  Map<String, dynamic> toJson() {
    return {
      'alamat': alamat,
      'no_hp': noHp,
      'kota': kota,
      'nik': nik,
      'booth_id': boothId, // Tambahkan ke JSON jika diperlukan
    };
  }
}

class Barang {
  final int id;
  final String namaBarang;
  final int kategoriId;
  final int brandId;
  final int stok;
  final int hargaPerhari;
  final String deskripsi;
  final double meanReview;
  final int totalReview;
  final String statusBarang;
  final DateTime tanggalDitambahkan;
  final String? foto;
  final bool? isWishlist;

  Barang({
    required this.id,
    required this.namaBarang,
    required this.kategoriId,
    required this.brandId,
    required this.stok,
    required this.hargaPerhari,
    required this.deskripsi,
    required this.meanReview,
    required this.totalReview,
    required this.statusBarang,
    required this.tanggalDitambahkan,
    this.foto,
    this.isWishlist,
  });
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'] ?? 0,
      namaBarang: json['nama_barang'] ?? '',
      kategoriId: json['kategori_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      stok: json['stok'] ?? 0,
      hargaPerhari: json['harga_perhari'] ?? 0,
      deskripsi: json['deskripsi'] ?? '',
      meanReview:
          (json['mean_review'] != null) ? json['mean_review'].toDouble() : 0.0,
      totalReview: json['total_review'] ?? 0,
      statusBarang: json['status_barang'] ?? '',
      tanggalDitambahkan: json['tanggal_ditambahkan'] != null
          ? DateTime.parse(json['tanggal_ditambahkan'])
          : DateTime.now(),
      foto: json['foto'],
      isWishlist: json['is_wishlist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_barang': namaBarang,
      'kategori_id': kategoriId,
      'brand_id': brandId,
      'stok': stok,
      'harga_perhari': hargaPerhari,
      'deskripsi': deskripsi,
      'mean_review': meanReview,
      'total_review': totalReview,
      'status_barang': statusBarang,
      'tanggal_ditambahkan': tanggalDitambahkan.toIso8601String(),
      'foto': foto,
      'is_wishlist': isWishlist,
    };
  }
}

class AuthResponse {
  final String message;
  final UserData? data;

  AuthResponse({
    required this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final int userId;
  final String nama;
  final String email;
  final String token;
  final String expiredDate;

  UserData({
    required this.userId,
    required this.nama,
    required this.email,
    required this.token,
    required this.expiredDate,
  });
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      expiredDate: json['expired_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nama': nama,
      'email': email,
      'token': token,
      'expired_date': expiredDate,
    };
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class RegisterRequest {
  final String nama;
  final String email;
  final String password;

  RegisterRequest({
    required this.nama,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'password': password,
    };
  }
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.success(T data, String message) {
    return ApiResponse(
      success: true,
      message: message,
      data: data,
    );
  }

  factory ApiResponse.error(String error) {
    return ApiResponse(
      success: false,
      message: '',
      error: error,
    );
  }
}

class Gunung {
  final int id;
  final String namaGunung;
  final String foto;
  final String lokasi;
  final String deskripsi;
  final List<Barang> barangList;

  Gunung({
    required this.id,
    required this.namaGunung,
    required this.foto,
    required this.lokasi,
    required this.deskripsi,
    this.barangList = const [],
  });

  factory Gunung.fromJson(Map<String, dynamic> json) {
    List<Barang> barangList = [];
    if (json['rekomendasi_barang'] != null &&
        json['rekomendasi_barang'] is List) {
      barangList = (json['rekomendasi_barang'] as List)
          .map((item) => Barang.fromJson(item))
          .toList();
    }

    return Gunung(
      id: json['id'] ?? 0,
      namaGunung: json['nama_gunung'] ?? '',
      foto: json['foto'] ?? '',
      lokasi: json['Lokasi'] ?? '',
      deskripsi: json['Deskripsi'] ?? '',
      barangList: barangList,
    );
  }
}

// Cart Models
class CartItem {
  final int id;
  final int kuantitas;
  final int subtotal;
  final int barangId;
  final String namaBarang;
  final int hargaPerhari;
  final String? foto;

  CartItem({
    required this.id,
    required this.kuantitas,
    required this.subtotal,
    required this.barangId,
    required this.namaBarang,
    required this.hargaPerhari,
    this.foto,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['item_keranjang_id'] ?? 0,
      kuantitas: json['kuantitas'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
      barangId: json['barang_id'] ?? 0,
      namaBarang: json['nama_barang'] ?? '',
      hargaPerhari: json['harga_perhari'] ?? 0,
      foto: json['foto'],
    );
  }
}

class Cart {
  final int id;
  final String? tanggalPengambilan;
  final String? tanggalPengembalian;
  final int? lamaPeminjaman;
  final int? totalBiayaHari;
  final int? totalBiayaDeposito;
  final List<CartItem> items;

  Cart({
    required this.id,
    this.tanggalPengambilan,
    this.tanggalPengembalian,
    this.lamaPeminjaman,
    this.totalBiayaHari,
    this.totalBiayaDeposito,
    required this.items,
  });
  factory Cart.fromJson(Map<String, dynamic> json) {
    final cartData = json['keranjang'] ?? {};
    final itemsData = (json['items'] as List<dynamic>?) ?? [];

    return Cart(
      id: cartData['id'] ?? 0,
      tanggalPengambilan: cartData['tanggal_pengambilan'],
      tanggalPengembalian: cartData['tanggal_pengembalian'],
      lamaPeminjaman: cartData['lama_peminjaman'],
      totalBiayaHari: cartData['total_biaya_hari'],
      totalBiayaDeposito: cartData['total_biaya_deposito'],
      items: itemsData.map((item) => CartItem.fromJson(item)).toList(),
    );
  }
}

class AddToCartRequest {
  final int userId;
  final List<AddToCartItem> items;

  AddToCartRequest({
    required this.userId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class AddToCartItem {
  final int barangId;
  final int kuantitas;

  AddToCartItem({
    required this.barangId,
    required this.kuantitas,
  });

  Map<String, dynamic> toJson() {
    return {
      'barang_id': barangId,
      'kuantitas': kuantitas,
    };
  }
}

// Wishlist Models
class WishlistRequest {
  final int userId;
  final int barangId;

  WishlistRequest({
    required this.userId,
    required this.barangId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'barang_id': barangId,
    };
  }
}

// Transaction Models
class TransactionRequest {
  final int userId;
  final int cabangPengambilanId;
  final String tanggalPengambilan;
  final String tanggalPengembalian;
  final String? statusTransaksi;
  final String? tanggalPengembalianAktual;
  final String? expiredPembayaran;

  TransactionRequest({
    required this.userId,
    required this.cabangPengambilanId,
    required this.tanggalPengambilan,
    required this.tanggalPengembalian,
    this.statusTransaksi,
    this.tanggalPengembalianAktual,
    this.expiredPembayaran,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'cabang_pengambilan_id': cabangPengambilanId,
      'tanggal_pengambilan': tanggalPengambilan,
      'tanggal_pengembalian': tanggalPengembalian,
      'status_transaksi': statusTransaksi ?? 'Belum Dibayar',
      'tanggal_pengembalian_aktual': tanggalPengembalianAktual,
      'expired_pembayaran': expiredPembayaran,
    };
  }
}

class PaymentRequest {
  final int transaksiId;
  final String metodePembayaran;
  final String tipePembayaran;
  final int totalPembayaran;
  final String? waktuPembuatan;

  PaymentRequest({
    required this.transaksiId,
    required this.metodePembayaran,
    required this.tipePembayaran,
    required this.totalPembayaran,
    this.waktuPembuatan,
  });

  Map<String, dynamic> toJson() {
    return {
      'transaksi_id': transaksiId,
      'metode_pembayaran': metodePembayaran,
      'tipe_pembayaran': tipePembayaran,
      'total_pembayaran': totalPembayaran,
      'waktu_pembuatan': waktuPembuatan,
    };
  }
}

// Review Models
class ReviewRequest {
  final int rating;
  final String ulasan;
  final int userId;
  final int barangId;

  ReviewRequest({
    required this.rating,
    required this.ulasan,
    required this.userId,
    required this.barangId,
  });

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'ulasan': ulasan,
      'user_id': userId,
      'barang_id': barangId,
    };
  }
}

// Tambahkan model Panduan
class Panduan {
  final String isiPanduan;
  final String? linkPanduan;

  Panduan({
    required this.isiPanduan,
    this.linkPanduan,
  });

  factory Panduan.fromJson(Map<String, dynamic> json) {
    return Panduan(
      isiPanduan: json['isi_panduan'] ?? '',
      linkPanduan: json['link_panduan'],
    );
  }
}

// Item Detail Models
class DetailBarang extends Barang {
  final List<FotoBarang>? fotoList;
  final List<Review>? reviews;
  final List<Panduan>? panduan; // Tambahkan field panduan

  DetailBarang({
    required super.id,
    required super.namaBarang,
    required super.kategoriId,
    required super.brandId,
    required super.stok,
    required super.hargaPerhari,
    required super.deskripsi,
    required super.meanReview,
    required super.totalReview,
    required super.statusBarang,
    required super.tanggalDitambahkan,
    super.foto,
    super.isWishlist,
    this.fotoList,
    this.reviews,
    this.panduan, // Tambahkan ke constructor
  });

  factory DetailBarang.fromJson(Map<String, dynamic> json) {
    List<FotoBarang>? fotoList;
    if (json['foto'] is List) {
      fotoList = (json['foto'] as List)
          .map((foto) => FotoBarang.fromJson(foto))
          .toList();
    }

    List<Review>? reviews;
    if (json['reviews'] != null) {
      reviews = (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList();
    }

    // Tambahkan parsing untuk panduan
    List<Panduan>? panduan;
    if (json['panduan'] != null) {
      panduan = (json['panduan'] as List)
          .map((panduanItem) => Panduan.fromJson(panduanItem))
          .toList();
    }

    return DetailBarang(
      id: json['id'] ?? 0,
      namaBarang: json['nama_barang'] ?? '',
      kategoriId: json['kategori_id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      stok: json['stok'] ?? 0,
      hargaPerhari: json['harga_perhari'] ?? 0,
      deskripsi: json['deskripsi'] ?? '',
      meanReview:
          (json['mean_review'] != null) ? json['mean_review'].toDouble() : 0.0,
      totalReview: json['total_review'] ?? 0,
      statusBarang: json['status_barang'] ?? '',
      tanggalDitambahkan: json['tanggal_ditambahkan'] != null
          ? DateTime.parse(json['tanggal_ditambahkan'])
          : DateTime.now(),
      foto: json['foto'] is String ? json['foto'] : null,
      isWishlist: json['is_wishlist'],
      fotoList: fotoList,
      reviews: reviews,
      panduan: panduan, // Tambahkan ke return
    );
  }
}

class FotoBarang {
  final String foto;
  final int urutan;

  FotoBarang({
    required this.foto,
    required this.urutan,
  });
  factory FotoBarang.fromJson(Map<String, dynamic> json) {
    return FotoBarang(
      foto: json['foto'] ?? '',
      urutan: json['urutan'] ?? 0,
    );
  }
}

class Review {
  final int rating;
  final String ulasan;
  final String namaUser;
  final String waktuPembuatan;

  Review({
    required this.rating,
    required this.ulasan,
    required this.namaUser,
    required this.waktuPembuatan,
  });
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] ?? 0,
      ulasan: json['ulasan'] ?? '',
      namaUser: json['nama_user'] ?? '',
      waktuPembuatan: json['waktu_pembuatan'] ?? '',
    );
  }
}

// User Transaction Model (for transaction history)
class UserTransaction {
  final int transaksiId;
  final String waktuPembuatan;
  final String statusTransaksi;
  final int jumlahBarang;
  final String pickupDate;
  final String returnDate;
  final int rentalDays;

  UserTransaction({
    required this.transaksiId,
    required this.waktuPembuatan,
    required this.statusTransaksi,
    required this.jumlahBarang,
    required this.pickupDate,
    required this.returnDate,
    required this.rentalDays,
  });

  factory UserTransaction.fromJson(Map<String, dynamic> json) {
    return UserTransaction(
      transaksiId: json['transaksi_id'],
      waktuPembuatan: json['waktu_pembuatan'],
      statusTransaksi: json['status_transaksi'],
      jumlahBarang: json['jumlah_barang'],
      pickupDate: json['tanggal_pengambilan'] ?? '',
      returnDate: json['tanggal_pengembalian'] ?? '',
      rentalDays: json['lama_peminjaman'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaksi_id': transaksiId,
      'waktu_pembuatan': waktuPembuatan,
      'status_transaksi': statusTransaksi,
      'jumlah_barang': jumlahBarang,
      'tanggal_pengambilan': pickupDate,
      'tanggal_pengembalian': returnDate,
      'lama_peminjaman': rentalDays,
    };
  }
}

// Transaction Detail Models
class TransactionDetail {
  final TransactionInfo transaction;
  final List<TransactionItem> items;

  TransactionDetail({
    required this.transaction,
    required this.items,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      transaction: TransactionInfo.fromJson(json['transaction']),
      items: (json['items'] as List)
          .map((item) => TransactionItem.fromJson(item))
          .toList(),
    );
  }
}

class TransactionInfo {
  final int transaksiId;
  final String statusTransaksi;
  final String waktuPembuatan;
  final String tanggalPengambilan;
  final String tanggalPengembalian;
  final String? tanggalPengembalianAktual;
  final int totalBiayaHari;
  final int totalBiayaDeposito;
  final int totalBiaya;

  TransactionInfo({
    required this.transaksiId,
    required this.statusTransaksi,
    required this.waktuPembuatan,
    required this.tanggalPengambilan,
    required this.tanggalPengembalian,
    this.tanggalPengembalianAktual,
    required this.totalBiayaHari,
    required this.totalBiayaDeposito,
    required this.totalBiaya,
  });

  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
      transaksiId: json['transaksi_id'] ?? 0,
      statusTransaksi: json['status_transaksi'] ?? '',
      waktuPembuatan: json['waktu_pembuatan'] ?? '',
      tanggalPengambilan: json['tanggal_pengambilan'] ?? '',
      tanggalPengembalian: json['tanggal_pengembalian'] ?? '',
      tanggalPengembalianAktual: json['tanggal_pengembalian_aktual'],
      totalBiayaHari: json['total_biaya_hari'] ?? 0,
      totalBiayaDeposito: json['total_biaya_deposito'] ?? 0,
      totalBiaya: json['total_biaya'] ?? 0,
    );
  }
}

class TransactionItem {
  final int barangId;
  final String namaBarang;
  final int hargaPerhari;
  final int kuantitas;
  final int subtotal;
  final String? foto;
  final bool isReviewed;

  TransactionItem({
    required this.barangId,
    required this.namaBarang,
    required this.hargaPerhari,
    required this.kuantitas,
    required this.subtotal,
    this.foto,
    required this.isReviewed,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      barangId: json['barang_id'] ?? 0,
      namaBarang: json['nama_barang'] ?? '',
      hargaPerhari: json['harga_perhari'] ?? 0,
      kuantitas: json['kuantitas'] ?? 0,
      subtotal: json['subtotal'] ?? 0,
      foto: json['foto'],
      isReviewed: json['is_reviewed'] ?? false,
    );
  }
}

// Notification Models
class NotificationItem {
  final int id;
  final String judul;
  final String deskripsi;
  final String jenis;
  final int userId;
  final DateTime waktuPembuatan;
  final int? dendaId;
  final int? transaksiId;
  final DetailDenda? detailDenda;
  final DetailTransaksi? detailTransaksi;

  NotificationItem({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.jenis,
    required this.userId,
    required this.waktuPembuatan,
    this.dendaId,
    this.transaksiId,
    this.detailDenda,
    this.detailTransaksi,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      jenis: json['jenis'] ?? '',
      userId: json['user_id'] ?? 0,
      waktuPembuatan: json['waktu_pembuatan'] != null
          ? DateTime.parse(json['waktu_pembuatan'])
          : DateTime.now(),
      dendaId: json['denda_id'],
      transaksiId: json['transaksi_id'],
      detailDenda: json['detail_denda'] != null
          ? DetailDenda.fromJson(json['detail_denda'])
          : null,
      detailTransaksi: json['detail_transaksi'] != null
          ? DetailTransaksi.fromJson(json['detail_transaksi'])
          : null,
    );
  }

  // Helper method to get formatted time
  String getFormattedTime() {
    final now = DateTime.now();
    final difference = now.difference(waktuPembuatan);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else {
      return '${difference.inDays} hari lalu';
    }
  }

  // Helper method to get icon based on notification type
  String getIconType() {
    switch (jenis) {
      case 'denda':
        return 'money_off';
      case 'transaksi':
        return 'receipt_long';
      case 'pengumuman':
        return 'campaign';
      default:
        return 'notifications';
    }
  }

  // Helper method to check if it's a penalty notification
  bool isPenalty() {
    return jenis == 'denda' && detailDenda != null;
  }
}

class DetailDenda {
  final int id;
  final int transaksiId;
  final int jumlahDenda;
  final String alasanDenda;
  final String statusDenda;

  DetailDenda({
    required this.id,
    required this.transaksiId,
    required this.jumlahDenda,
    required this.alasanDenda,
    required this.statusDenda,
  });

  factory DetailDenda.fromJson(Map<String, dynamic> json) {
    return DetailDenda(
      id: json['id'] ?? 0,
      transaksiId: json['transaksi_id'] ?? 0,
      jumlahDenda: json['total_denda'] ?? 0,
      alasanDenda: json['catatan'] ?? '',
      statusDenda: json['status_denda'] ?? '',
    );
  }
}

class DetailTransaksi {
  final int id;
  final String statusTransaksi;
  final DateTime waktuPembuatan;

  DetailTransaksi({
    required this.id,
    required this.statusTransaksi,
    required this.waktuPembuatan,
  });

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      id: json['id'] ?? 0,
      statusTransaksi: json['status_transaksi'] ?? '',
      waktuPembuatan: json['waktu_pembuatan'] != null
          ? DateTime.parse(json['waktu_pembuatan'])
          : DateTime.now(),
    );
  }
}

class NotificationResponse {
  final List<NotificationItem> data;
  final String? error;

  NotificationResponse({
    required this.data,
    this.error,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    List<NotificationItem> notifications = [];
    if (json['data'] != null) {
      notifications = (json['data'] as List)
          .map((item) => NotificationItem.fromJson(item))
          .toList();
    }

    return NotificationResponse(
      data: notifications,
      error: json['error'],
    );
  }
}
