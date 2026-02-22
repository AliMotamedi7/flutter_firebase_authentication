import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/core/router/routes.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser == null && route != Routes.auth) {
      return const RouteSettings(name: Routes.auth);
    }
    if (FirebaseAuth.instance.currentUser != null && route == Routes.auth) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}
