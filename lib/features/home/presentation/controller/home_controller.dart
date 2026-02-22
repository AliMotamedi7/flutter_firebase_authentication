import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/core/router/routes.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends GetxController with StateMixin {
  /// -------------------Constructor------------------

  /// -------------------UseCases---------------------

  @override
  void onInit() {
    super.onInit();
    change('', status: RxStatus.success());
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  /// -------------------Variables---------------------

  /// -------------------Controllers------------------
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController textController = TextEditingController();

  /// -------------------Status-----------------------

  /// -------------------Functions--------------------
  Future<void> logOut() async {
    await firebaseAuth.signOut();
    Get.offAndToNamed(Routes.auth);
  }

/// -------------------Api Callings--------------------
}
