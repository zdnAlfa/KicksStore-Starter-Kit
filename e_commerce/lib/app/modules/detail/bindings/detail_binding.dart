
import 'package:get/get.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(
      () => DetailController(),
    );
    
    if (!Get.isRegistered<CartController>()) {
      Get.lazyPut<CartController>(
        () => CartController(),
        fenix: true,
      );
    }
  }
}