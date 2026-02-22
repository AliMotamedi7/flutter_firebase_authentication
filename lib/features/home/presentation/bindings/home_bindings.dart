import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_firebase_authentication/features/home/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());

    if (Get.isRegistered<AuthController>()) {
      Get.delete<AuthController>(force: true);
    }
  }

  Future<void> inDependencies() async {
    await Get.delete<HomeController>();
  }

  Future<void> refreshPage() async {
    await inDependencies();
    dependencies();
  }
}
