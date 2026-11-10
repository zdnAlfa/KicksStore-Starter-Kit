import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/data/models/cart_item_model.dart';
import 'package:e_commerce/app/data/models/product_model.dart';

class CartController extends GetxController {
  
  final items = <CartItemModel>[].obs;

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void onInit() {
    super.onInit();
    _seedInitialCartItems();
  }

  void _seedInitialCartItems() {
    items.assignAll([
      CartItemModel(
        id: 'shoe-01_42',
        product: const ProductModel(
          id: 'shoe-01',
          name: 'Nike Air Jordan 1 High OG',
          category: 'Basketball',
          price: 2499000,
          rating: 4.9,
          reviewCount: 312,
          imageUrl:
              'https://images.unsplash.com/photo-1552346154-21d32810aba3?auto=format&fit=crop&w=800&q=80',
          description:
              'Sepatu legendaris dengan material kulit premium, bantalan Air-Sole klasik, dan sol traksi karet tangguh.',
        ),
        selectedSize: '42',
        quantity: 1,
      ),
      CartItemModel(
        id: 'shoe-03_41',
        product: const ProductModel(
          id: 'shoe-03',
          name: 'Puma Slipstream Retro Bball',
          category: 'Casual',
          price: 1499000,
          rating: 4.7,
          reviewCount: 84,
          imageUrl:
              'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&w=800&q=80',
          description:
              'Kembalinya siluet basket era 80-an dengan sentuhan suede lembut dan sol karet tebal.',
        ),
        selectedSize: '41',
        quantity: 1,
      ),
    ]);
  }

 
  int get totalItemCount =>
      items.fold<int>(0, (sum, item) => sum + item.quantity);

  
  int get subtotal =>
      items.fold<int>(0, (sum, item) => sum + item.subtotal);

 
  int get tax => (subtotal * 0.11).round();

  
  int get shippingFee => items.isEmpty ? 0 : 25000;

  // Total pembayaran akhir
  int get totalAmount => subtotal + tax + shippingFee;

  String get formattedSubtotal => currencyFormatter.format(subtotal);
  String get formattedTax => currencyFormatter.format(tax);
  String get formattedShippingFee => currencyFormatter.format(shippingFee);
  String get formattedTotalAmount => currencyFormatter.format(totalAmount);

  void addItem(ProductModel product, {int quantity = 1, String size = '42'}) {
    final cartItemId = '${product.id}_$size';
    final existingIndex = items.indexWhere((item) => item.id == cartItemId);

    if (existingIndex != -1) {
      items[existingIndex].quantity += quantity;
      items.refresh();
    } else {
      items.add(
        CartItemModel(
          id: cartItemId,
          product: product,
          selectedSize: size,
          quantity: quantity,
        ),
      );
    }

    Get.snackbar(
      'Keranjang Diperbarui',
      '$quantity pasang ${product.name} (Ukuran $size) ditambahkan!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
    );
  }

  // Tambah kuantitas 1 item
  void increaseQuantity(String cartItemId) {
    final index = items.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      items[index].quantity++;
      items.refresh();
    }
  }

  // Kurangi kuantitas 1 item
  void decreaseQuantity(String cartItemId) {
    final index = items.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
        items.refresh();
      } else {
        // Konfirmasi hapus jika kuantitas mencapai 1
        removeItem(cartItemId);
      }
    }
  }

  // Hapus item dari keranjang
  void removeItem(String cartItemId) {
    final removedItem = items.firstWhereOrNull((item) => item.id == cartItemId);
    items.removeWhere((item) => item.id == cartItemId);

    if (removedItem != null) {
      Get.snackbar(
        'Item Dihapus',
        '${removedItem.product.name} dikeluarkan dari keranjang.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF334155),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      );
    }
  }

  // Kosongkan keranjang (setelah checkout)
  void clearCart() {
    items.clear();
  }
}