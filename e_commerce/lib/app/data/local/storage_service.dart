import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service penyimpanan data lokal terpusat (Sesi 06: Local Storage & Inisialisasi Hive CE)
class StorageService extends GetxService {
  static const String _themeKey = 'is_dark_mode';

  late final SharedPreferences _prefs;

  // State reaktif tema aplikasi
  final RxBool _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// Inisialisasi asynchronous SharedPreferences dan Hive CE sebelum UI dirender
  Future<StorageService> init({bool initHive = true}) async {
    // 1. Muat preferensi primitif melalui SharedPreferences
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = _prefs.getBool(_themeKey) ?? false;

    // 2. Inisialisasi NoSQL Object Database Hive CE untuk platform mobile/desktop/web
    if (initHive) {
      await Hive.initFlutter();
    }

    return this;
  }

  /// Mengubah mode tema dan menyimpannya secara persisten ke SharedPreferences
  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    await _prefs.setBool(_themeKey, _isDarkMode.value);

    // Perbarui mode tema secara dinamis di GetMaterialApp
    Get.changeThemeMode(themeMode);

    // Tantangan Mandiri: Feedback SnackBar sesuai tema yang aktif
    if (_isDarkMode.value) {
      Get.snackbar(
        'Mode Gelap Diaktifkan',
        'Tampilan hemat daya dan nyaman untuk mata telah aktif.',
        backgroundColor: const Color(0xFF1E293B),
        colorText: Colors.white,
        icon: const Icon(Icons.dark_mode_rounded, color: Colors.amber),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Mode Terang Diaktifkan',
        'Tampilan cerah bersemangat telah aktif.',
        backgroundColor: const Color(0xFF4F46E5),
        colorText: Colors.white,
        icon: const Icon(Icons.light_mode_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Getter SharedPreferences jika modul lain memerlukan akses key-value
  SharedPreferences get prefs => _prefs;
}