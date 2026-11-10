import 'package:get/get.dart';
import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';

class WishlistController extends GetxController {
  late final HomeController homeController;
  late final CartController cartController;

  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>();
    cartController = Get.find<CartController>();
  }

  List<ProductModel> get wishlistItems {
    return homeController.products.where((product) {
      return homeController.favoriteIds.contains(product.id);
    }).toList();
  }

  void removeFromWishlist(String productId) {
    homeController.toggleFavorite(productId);
  }

  void moveToCart(ProductModel product) {
    cartController.addItem(product, quantity: 1, size: '42');
    homeController.toggleFavorite(product.id);
  }
}