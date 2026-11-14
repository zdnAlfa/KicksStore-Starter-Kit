import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/routes/app_pages.dart';

/// Controller Manajemen Form Login (Sesi 04: Form Handling & Validasi Input)
class LoginController extends GetxController {
  // GlobalKey untuk memvalidasi seluruh TextFormField dalam Form
  final formKey = GlobalKey<FormState>();

  // TextEditingController untuk menangkap teks input
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  // State Reaktif GetX untuk UI interaktif
  final isPasswordHidden = true.obs;
  final rememberMe = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    // Edukasi SMK: Selalu dispose controller input untuk mencegah kebocoran memori (memory leak)
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle visibilitas kata sandi (lihat / sembunyikan)
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Toggle checkbox Ingat Saya
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Validasi Alamat Email dengan Regular Expression (Regex)
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Alamat email wajib diisi';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid (contoh: nama@sekolah.sch.id)';
    }
    return null;
  }

  // Validasi Kata Sandi (Minimal 6 karakter)
  String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Kata sandi wajib diisi';
  }
  if (value.length < 6) {
    return 'Kata sandi minimal 6 karakter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Kata sandi harus mengandung minimal 1 angka (0-9)';
  }
  return null;
}

  // Aksi Masuk Akun
  Future<void> login() async {
    // 1. Jalankan validasi seluruh field form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // 2. Aktifkan indikator loading
    isLoading.value = true;

    try {
      // Simulasi delay request jaringan (akan digantikan Firebase Auth di Sesi 09)
      await Future.delayed(const Duration(milliseconds: 1200));

      Get.snackbar(
        'Berhasil Masuk 🎉',
        'Selamat datang kembali di KicksStore!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      );

      // Navigasi ke Beranda dan bersihkan riwayat rute auth
      Get.offAllNamed(Routes.HOME);
    } finally {
      isLoading.value = false;
    }
  }
}