import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce/app/modules/home/views/components/product_card.dart';
import 'package:e_commerce/app/modules/home/views/components/promo_banner.dart';
import 'package:e_commerce/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.electric_bolt_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
                children: const [
                  TextSpan(text: 'Kicks'),
                  TextSpan(text: 'Store', style: TextStyle(color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Wishlist Favorit',
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () => Get.toNamed(Routes.WISHLIST),
          ),
          IconButton(
            tooltip: 'Riwayat Pesanan',
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => Get.toNamed(Routes.ORDERS),
          ),
          IconButton(
            tooltip: 'Ganti Tema',
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? AppColors.accent : AppColors.lightTextPrimary,
            ),
            onPressed: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                tooltip: 'Keranjang Belanja',
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Get.toNamed(Routes.CART),
              ),
              Obx(() {
                final count = cartController.totalItemCount;
                if (count == 0) return const SizedBox.shrink();
                return Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$count',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Sneakers Enthusiast!',
                      style: TextStyle(fontSize: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Temukan Sepatu Impianmu',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.LOGIN),
                  borderRadius: BorderRadius.circular(24),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 26),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceCard : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Air Jordan, Ultraboost, 550...',
                        hintStyle: TextStyle(fontSize: 14, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.tune_rounded, size: 20), color: AppColors.primary, onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const PromoBanner(),
            const SizedBox(height: 20),

            Obx(() {
              return SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    final isSelected = controller.selectedCategory.value == category;
                    return InkWell(
                      onTap: () => controller.changeCategory(category),
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : (isDark ? AppColors.darkSurfaceCard : Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.white : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 20),

            Obx(() {
              final count = controller.filteredProducts.length;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Katalog Sneakers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)),
                  Text('$count Produk', style: TextStyle(fontSize: 13, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                ],
              );
            }),
            const SizedBox(height: 12),

            Obx(() {
              final items = controller.filteredProducts;
              if (items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded, size: 48, color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                        const SizedBox(height: 8),
                        Text('Tidak ada produk di kategori ini', style: TextStyle(color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                      ],
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductCard(
                    title: product.name,
                    category: product.category,
                    price: currencyFormatter.format(product.price),
                    rating: product.rating,
                    imageUrl: product.imageUrl,
                    isFavorite: controller.isFavorite(product.id),
                    onTap: () => controller.openDetail(product),
                    onAddToCart: () => controller.addToCart(product),
                    onToggleFavorite: () => controller.toggleFavorite(product.id),
                  );
                },
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        backgroundColor: isDark ? AppColors.darkSurfaceCard : Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Pesanan'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Akun'),
        ],
        onTap: (index) {
          if (index == 1) Get.toNamed(Routes.WISHLIST);
          if (index == 2) Get.toNamed(Routes.ORDERS);
          if (index == 3) Get.toNamed(Routes.LOGIN);
        },
      ),
    );
  }
}