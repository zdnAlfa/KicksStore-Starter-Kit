import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';

/// Controller Manajemen Form Registrasi (Sesi 04: Form Handling & Validasi Input)
class RegisterController extends GetxController {
  // GlobalKey untuk validasi form pendaftaran akun
  final formKey = GlobalKey<FormState>();

  // TextEditingController untuk menangkap seluruh data input siswa
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  // State Reaktif GetX untuk visibilitas sandi dan indikator loading
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    // Edukasi SMK: Wajib dispose seluruh TextEditingController saat controller dimusnahkan
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle visibilitas kata sandi utama
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Toggle visibilitas konfirmasi kata sandi
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Validasi Nama Lengkap (Minimal 3 karakter)
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    if (value.trim().length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
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

  // Validasi Konfirmasi Kata Sandi (Wajib identik dengan passwordController)
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi wajib diisi';
    }
    if (value != passwordController.text) {
      return 'Konfirmasi kata sandi tidak cocok dengan sandi di atas';
    }
    return null;
  }

  // Aksi Pendaftaran Akun Baru
  Future<void> register() async {
    // 1. Jalankan validasi seluruh field input
    if (!formKey.currentState!.validate()) {
      return;
    }

    // 2. Aktifkan indikator loading
    isLoading.value = true;

    try {
      // Simulasi delay request jaringan (akan digantikan Firebase Auth di Sesi 09)
      await Future.delayed(const Duration(milliseconds: 1200));

      Get.snackbar(
        'Pendaftaran Berhasil 🎉',
        'Akun untuk ${nameController.text.trim()} berhasil dibuat! Silakan masuk.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      );

      // Kembali ke halaman Login
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }
}