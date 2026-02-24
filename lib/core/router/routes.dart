import 'package:flutter_firebase_authentication/core/middleware/auth_middleware.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/view/auth_page.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/view/email_verification_password_page.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/view/register_page.dart';
import 'package:flutter_firebase_authentication/features/home/presentation/bindings/home_bindings.dart';
import 'package:flutter_firebase_authentication/features/home/presentation/view/home_page.dart';
import 'package:flutter_firebase_authentication/features/splash/presentation/bindings/splash_bindings.dart';
import 'package:flutter_firebase_authentication/features/splash/presentation/view/splash_page.dart';
import 'package:get/get.dart';

class Routes {
  const Routes._();

  /// Auth
  static const String splash = '/splash';

  /// Auth
  static const String auth = '/auth';
  static const String register = '/register';
  static const String resetPassword = '/resetPassword';
  static const String emailVerificationPassword = '/email_verification_password';

  /// Home
  static const String home = '/home';
}

List<GetPage> get pages => [
  GetPage(
    name: Routes.splash,
    binding: SplashBindings(),
    page: () => const SplashPage(),
  ),
  GetPage(
    name: Routes.auth,
    binding: AuthBindings(),
    page: () => const AuthPage(),
    showCupertinoParallax: false,
    middlewares: [AuthMiddleware()],
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.register,
    binding: AuthBindings(),
    showCupertinoParallax: false,
    page: () => const RegisterPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.emailVerificationPassword,
    binding: AuthBindings(),
    showCupertinoParallax: false,
    page: () => const EmailVerificationPasswordPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.resetPassword,
    binding: AuthBindings(),
    showCupertinoParallax: false,
    page: () => const RegisterPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.home,
    binding: HomeBindings(),
    showCupertinoParallax: false,
    page: () => const HomePage(),
    transition: Transition.rightToLeft,
  ),
];
