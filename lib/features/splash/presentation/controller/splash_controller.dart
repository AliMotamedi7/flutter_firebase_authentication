import 'package:flutter_firebase_authentication/core/router/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with StateMixin {
  /// -------------------Constructor------------------

  /// -------------------UseCases---------------------

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 30), () {
      Get.offAllNamed(Routes.auth);
    });
    change('', status: RxStatus.success());
  }

  /// -------------------Variables---------------------

  /// -------------------Controllers------------------

  /// -------------------Status-----------------------

  /// -------------------Functions--------------------

/// -------------------Api Callings--------------------
}
