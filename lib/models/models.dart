class User {
  final int id;
  final String nama;
  final String email;
  final String? alamat;
  final String? noHp;
  final String? kota;
  final String? gambar;
  final DateTime tanggalDaftar;
  final String statusAkun;

  User({
    required this.id,
    required this.nama,
    required this.email,
    this.alamat,
    this.noHp,
    this.kota,
    this.gambar,
    required this.tanggalDaftar,
    required this.statusAkun,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      kota: json['kota'],
      gambar: json['gambar'],
      tanggalDaftar: DateTime.parse(json['tanggal_daftar']),
      statusAkun: json['status_akun'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'alamat': alamat,
      'no_hp': noHp,
      'kota': kota,
      'gambar': gambar,
      'tanggal_daftar': tanggalDaftar.toIso8601String(),
      'status_akun': statusAkun,
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
      id: json['id'],
      namaBarang: json['nama_barang'],
      kategoriId: json['kategori_id'],
      brandId: json['brand_id'],
      stok: json['stok'],
      hargaPerhari: json['harga_perhari'],
      deskripsi: json['deskripsi'],
      meanReview: json['mean_review'].toDouble(),
      totalReview: json['total_review'],
      statusBarang: json['status_barang'],
      tanggalDitambahkan: DateTime.parse(json['tanggal_ditambahkan']),
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
      userId: json['user_id'],
      nama: json['nama'],
      email: json['email'],
      token: json['token'],
      expiredDate: json['expired_date'],
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
