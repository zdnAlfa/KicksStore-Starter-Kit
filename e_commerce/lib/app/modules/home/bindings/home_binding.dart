

import 'package:get/get.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    
    if (!Get.isRegistered<CartController>()) {
      Get.lazyPut<CartController>(
        () => CartController(),
        fenix: true,
      );
    }
  }
}