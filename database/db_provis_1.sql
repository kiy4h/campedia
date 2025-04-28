/*
 Navicat Premium Data Transfer

 Source Server         : adsad
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : db_provis

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 28/04/2025 20:17:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for akun
-- ----------------------------
DROP TABLE IF EXISTS `akun`;
CREATE TABLE `akun`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'dalam bentuk HASH!',
  `last_login` datetime NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'untuk lupa password',
  `expire_token` datetime NOT NULL COMMENT 'kapan token tidak lagi dapat digunakan',
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_akun_1`(`user_id` ASC) USING BTREE,
  CONSTRAINT `idfk_akun_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for barang
-- ----------------------------
DROP TABLE IF EXISTS `barang`;
CREATE TABLE `barang`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kategori_id` int NOT NULL,
  `stok` int NOT NULL,
  `harga_perhari` int NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mean_review` int NOT NULL COMMENT 'rata-rata dari tabel review',
  `total_review` int NOT NULL COMMENT 'kuantitas review barang ini',
  `status_barang` enum('available','not_available') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available' COMMENT 'available|not available',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_barang_1`(`kategori_id` ASC) USING BTREE,
  CONSTRAINT `idfk_barang_1` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for diskusi
-- ----------------------------
DROP TABLE IF EXISTS `diskusi`;
CREATE TABLE `diskusi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `isi_diskusi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `barang_id` int NOT NULL,
  `user_id` int NULL DEFAULT NULL COMMENT 'boleh NULL, karena ada kemungkinan user terkena ban dan dihapus',
  `waktu_pembuatan` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_diskusi_1`(`barang_id` ASC) USING BTREE,
  INDEX `idfk_diskusi_2`(`user_id` ASC) USING BTREE,
  CONSTRAINT `idfk_diskusi_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idfk_diskusi_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for foto_barang
-- ----------------------------
DROP TABLE IF EXISTS `foto_barang`;
CREATE TABLE `foto_barang`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'url?',
  `urutan` int NOT NULL COMMENT 'urutan tampilan',
  `barang_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_foto_1`(`barang_id` ASC) USING BTREE,
  CONSTRAINT `idfk_foto_1` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for item_keranjang
-- ----------------------------
DROP TABLE IF EXISTS `item_keranjang`;
CREATE TABLE `item_keranjang`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal_pengambilan` date NOT NULL,
  `tanggal_pengembalian` date NOT NULL,
  `kuantitas` int NOT NULL,
  `subtotal` int NOT NULL,
  `keranjang_id` int NOT NULL,
  `barang_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_itemkeranjang_1`(`keranjang_id` ASC) USING BTREE,
  INDEX `idfk_itemkeranjang_2`(`barang_id` ASC) USING BTREE,
  CONSTRAINT `idfk_itemkeranjang_1` FOREIGN KEY (`keranjang_id`) REFERENCES `keranjang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idfk_itemkeranjang_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kategori
-- ----------------------------
DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for keranjang
-- ----------------------------
DROP TABLE IF EXISTS `keranjang`;
CREATE TABLE `keranjang`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `status` enum('aktif','checkout') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ketika checkout, buat keranjang baru',
  `tanggal_dibuat` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_keranjang_1`(`user_id` ASC) USING BTREE,
  CONSTRAINT `idfk_keranjang_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi
-- ----------------------------
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE `transaksi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tanggal_pembayaran` date NOT NULL,
  `metode_pembayaran` enum('Qris','Transfer') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_biaya` int NOT NULL,
  `status_pembayaran` enum('Belum Dibayar','Sudah Dibayar') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Belum Dibayar',
  `status_pengembalian` enum('Belum Dikembalikan','Sudah Dikembalikan') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Belum Dikembalikan',
  `keranjang_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_transaksi_1`(`keranjang_id` ASC) USING BTREE,
  INDEX `idfk_transaksi_2`(`user_id` ASC) USING BTREE,
  CONSTRAINT `idfk_transaksi_1` FOREIGN KEY (`keranjang_id`) REFERENCES `keranjang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idfk_transaksi_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_hp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `gambar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_daftar` date NOT NULL,
  `status_akun` enum('aktif','tidak_aktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'aktif' COMMENT 'aktif/tidak aktif',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wishlist
-- ----------------------------
DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `barang_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idfk_wishlist_1`(`user_id` ASC) USING BTREE,
  INDEX `idfk_wishlist_2`(`barang_id` ASC) USING BTREE,
  CONSTRAINT `idfk_wishlist_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idfk_wishlist_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
