import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // 1. STATE (Observable)
  // .obs membuat variabel ini "didengarkan" oleh Obx di UI
  final cartCount = 0.obs;
  final selectedCategory = 'Semua'.obs;
  final favoriteIds = <String>{}.obs;

  // 2. DATA & KONFIGURASI
  final categories = <String>[
    'Semua',
    'Running',
    'Casual',
    'Basketball',
    'Lifestyle',
  ];

  // Mock Data Katalog Sepatu KicksStore
  final products = <Map<String, dynamic>>[
    {
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
    },
    {
      'id': 'shoe-02',
      'name': 'Adidas Ultraboost Light 23',
      'category': 'Running',
      'price': 3100000,
      'rating': 4.8,
      'reviewCount': 195,
      'imageUrl':
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&w=800&q=80',
      'description':
          'Sepatu lari paling responsif dengan teknologi bantalan Light BOOST 30% lebih ringan, memberikan dorongan energi tanpa henti di setiap kilometer.',
    },
    {
      'id': 'shoe-03',
      'name': 'Puma Slipstream Retro Bball',
      'category': 'Casual',
      'price': 1499000,
      'rating': 4.7,
      'reviewCount': 84,
      'imageUrl':
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&w=800&q=80',
      'description':
          'Kembalinya siluet basket era 80-an dengan pembaruan modern. Sentuhan suede lembut dan sol karet tebal yang sangat pas untuk outfit harian.',
    },
    {
      'id': 'shoe-04',
      'name': 'New Balance 550 Vintage White',
      'category': 'Casual',
      'price': 2099000,
      'rating': 4.9,
      'reviewCount': 420,
      'imageUrl':
          'https://images.unsplash.com/photo-1539185441755-769473a23570?auto=format&fit=crop&w=800&q=80',
      'description':
          'Desain clean dan vintage yang mendominasi tren streetwear dunia. Tahan lama, nyaman, dan mudah dipadukan dengan berbagai celana.',
    },
    {
      'id': 'shoe-05',
      'name': 'Nike ZoomX Vaporfly Next% 3',
      'category': 'Running',
      'price': 3899000,
      'rating': 5.0,
      'reviewCount': 118,
      'imageUrl':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80',
      'description':
          'Sepatu marathon kompetisi tercepat dengan pelat serat karbon penuh dan busa ZoomX yang memberikan efisiensi tenaga superior di garis finis.',
    },
    {
      'id': 'shoe-06',
      'name': 'Converse Chuck 70 Canvas High',
      'category': 'Lifestyle',
      'price': 999000,
      'rating': 4.8,
      'reviewCount': 560,
      'imageUrl':
          'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?auto=format&fit=crop&w=800&q=80',
      'description':
          'Versi premium dari siluet Chuck Taylor klasik dengan kanvas 12oz lebih tebal, jahitan samping vintage, dan insole OrthoLite super empuk.',
    },
  ];

  // 3. GETTERS
  // Otomatis rebuild saat selectedCategory berubah
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory.value == 'Semua') {
      return products;
    }
    return products
        .where((item) => item['category'] == selectedCategory.value)
        .toList();
  }

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  // 4. FUNCTIONS
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void addToCart(Map<String, dynamic> product) {
    cartCount.value++;
    Get.snackbar(
      'Keranjang Diperbarui',
      '${product['name']} berhasil ditambahkan!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
    );
  }

  void toggleFavorite(String productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
      Get.snackbar(
        'Dihapus dari Wishlist',
        'Sepatu berhasil dihapus dari daftar favorit!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF6B7280).withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.heart_broken_outlined, color: Colors.white),
      );
    } else {
      favoriteIds.add(productId);
      Get.snackbar(
        'Disimpan ke Wishlist',
        'Sepatu berhasil ditambahkan ke daftar favorit!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4F46E5).withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.favorite, color: Colors.white),
      );
    }
  }

  void openDetail(Map<String, dynamic> product) {
    Get.toNamed('/detail', arguments: product);
  }
}