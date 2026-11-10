import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';

class DetailController extends GetxController {
  final product = Rx<ProductModel?>(null);
  final quantity = 1.obs;
  final selectedSize = '42'.obs;
  final isFavorite = false.obs;

  final availableSizes = ['40', '41', '42', '43', '44'];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      product.value = ProductModel.fromMap(args);
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
  }

  void addToCart() {
    final currentProduct = product.value;
    if (currentProduct != null) {
      Get.find<CartController>().addItem(
        currentProduct,
        quantity: quantity.value,
        size: selectedSize.value,
      );
    }
  }
}