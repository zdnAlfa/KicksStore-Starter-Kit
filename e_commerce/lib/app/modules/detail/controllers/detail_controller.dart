import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';

class DetailController extends GetxController {
  final product = <String, dynamic>{}.obs;
  final quantity = 1.obs;
  final selectedSize = '42'.obs;
  final isFavorite = false.obs;

  final availableSizes = ['40', '41', '42', '43', '44'];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      product.assignAll(Get.arguments as Map<String, dynamic>);
      if (Get.isRegistered<HomeController>()) {
        final homeController = Get.find<HomeController>();
        isFavorite.value = homeController.isFavorite(product['id'] ?? '');
      }
    } else {
      product.assignAll({
        'id': 'shoe-01',
        'name': 'Nike Air Jordan 1 High OG',
        'category': 'Basketball',
        'price': 2499000,
        'rating': 4.9,
        'reviewCount': 312,
        'imageUrl':
            'https://images.unsplash.com/photo-1552346154-21d32810aba3?auto=format&fit=crop&w=800&q=80',
        'description':
            'Sepatu legendaris dengan material kulit premium, bantalan Air-Sole klasik, dan sol traksi karet tangguh untuk gaya hidup dan performa maksimal.',
      });
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void changeSize(String size) {
    selectedSize.value = size;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      final productId = product['id'] ?? '';
      if (isFavorite.value) {
        homeController.favoriteIds.add(productId);
      } else {
        homeController.favoriteIds.remove(productId);
      }
    }
  }

  void addToCart() {
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      homeController.cartCount.value += quantity.value;
    }

    Get.snackbar(
      'Berhasil Ditambahkan',
      '${quantity.value} pasang ${product['name']} (Ukuran ${selectedSize.value}) dimasukkan ke keranjang belanja!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
    );
  }
}