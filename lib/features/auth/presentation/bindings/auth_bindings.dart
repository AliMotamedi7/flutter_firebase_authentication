import 'package:get/get.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }

  Future<void> inDependencies() async {
    await Get.delete<AuthController>(force: true);
  }

  Future<void> refreshPage() async {
    await inDependencies();
    dependencies();
  }
}
