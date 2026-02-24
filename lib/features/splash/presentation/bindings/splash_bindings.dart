import 'package:flutter_firebase_authentication/features/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }

  Future<void> inDependencies() async {
    await Get.delete<SplashController>();
  }

  Future<void> refreshPage() async {
    await inDependencies();
    dependencies();
  }
}
