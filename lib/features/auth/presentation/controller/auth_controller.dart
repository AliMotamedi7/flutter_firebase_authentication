import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_authentication/core/router/routes.dart';
import 'package:flutter_firebase_authentication/core/status/base_status.dart';
import 'package:flutter_firebase_authentication/core/utils/deep_link_handler.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController with StateMixin {
  /// -------------------Constructor------------------

  /// -------------------UseCases---------------------

  @override
  void onInit() {
    super.onInit();
    DeepLinkHandler.instance.initDeepLinks();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// -------------------Variables---------------------
  final RxBool showHidePassword = RxBool(false);

  /// -------------------Controllers------------------
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  /// -------------------Status-----------------------
  final Rx<BaseStatus> loginStatus = Rx(const BaseNoAction());
  final Rx<BaseStatus> createAccountStatus = Rx(const BaseNoAction());
  final Rx<BaseStatus> resetPasswordStatus = Rx(const BaseNoAction());
  final Rx<BaseStatus> emailVerificationPasswordStatus = Rx(const BaseNoAction());

  /// -------------------Functions--------------------
  void togglePassword() {
    showHidePassword.value = !showHidePassword.value;
  }

  void goToRegister() {
    showHidePassword.value = false;
    passwordController.clear();
    Get.offAndToNamed(Routes.register);
  }

  void goToLogin() {
    showHidePassword.value = false;
    passwordController.clear();
    confirmPasswordController.clear();
    Get.offAndToNamed(Routes.auth);
  }

  void goToForgotPassword() {
    showHidePassword.value = false;
    passwordController.clear();
    Get.offAndToNamed(Routes.emailVerificationPassword);
  }

  /// -------------------Api Callings--------------------
  Future<void> login() async {
    loginStatus.value = const BaseLoading();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      loginStatus.value = BaseSuccess(NoParams());
      Get.offAndToNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      loginStatus.value = BaseError(e.message);
    } catch (e) {
      debugPrint('$e _____');
      loginStatus.value = BaseError("An unexpected error occurred.");
    }
  }

  Future<void> createAccount() async {
    createAccountStatus.value = const BaseLoading();
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      createAccountStatus.value = BaseSuccess(NoParams());
      Get.offAndToNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      createAccountStatus.value = BaseError(e.message);
    } catch (e) {
      debugPrint('$e _____');
      createAccountStatus.value = BaseError("An unexpected error occurred.");
    }
  }

  Future<void> sendPasswordResetEmail() async {
    emailVerificationPasswordStatus.value = const BaseLoading();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
        actionCodeSettings: ActionCodeSettings(
          url: 'https://authentication-test-719b2.firebaseapp.com/resetPassword',
          handleCodeInApp: true,
          androidPackageName: 'com.example.flutter_firebase_authentication',
          androidInstallApp: true,
          iOSBundleId: 'com.example.flutterFirebaseAuthentication',
        ),
      );
      emailVerificationPasswordStatus.value = BaseSuccess(NoParams());
      Get.snackbar("Success", "Reset email sent!");
    } on FirebaseAuthException catch (e) {
      emailVerificationPasswordStatus.value = BaseError(e.message);
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> confirmPasswordChange(String newPassword) async {
    resetPasswordStatus.value = const BaseLoading();
    final String oobCode = Get.arguments;
    try {
      await FirebaseAuth.instance.confirmPasswordReset(
        code: oobCode,
        newPassword: passwordController.text,
      );
      resetPasswordStatus.value = BaseSuccess(NoParams());
      Get.snackbar("Success", "Password changed! Please login.");
      Get.offAllNamed(Routes.auth);
    } on FirebaseAuthException catch (e) {
      resetPasswordStatus.value = BaseError(e.message);
      Get.snackbar("Error", "Link expired or invalid.");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId: '452666345373-l67q98suos58t96d1fh9l8jhss66mett.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Get.offAndToNamed(Routes.home);

    } on GoogleSignInException catch (e) {
      if (kDebugMode) {
        print("Google Sign In Error: ${e.code}, $e");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected error: $e");
      }
    }
  }

  Future<UserCredential?> signUpWithGoogle() async {
    try {
      // 1. Initialize GoogleSignIn with your Web Client ID
      await GoogleSignIn.instance.initialize(
        serverClientId: '452666345373-l67q98suos58t96d1fh9l8jhss66mett.apps.googleusercontent.com',
      );

      // 2. Trigger the Google authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 5. Pass the credential to Firebase (This creates the account if it doesn't exist)
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        print("🎉 Success! A brand new account was created for: ${userCredential.user?.email}");
      } else {
        print("👋 Welcome back! Logged in as: ${userCredential.user?.email}");
      }

      return userCredential;

    } on GoogleSignInException catch (e) {
      print("Google Sign In Error: ${e.code}, $e");
      return null;
    } catch (e) {
      print("Unexpected error during Google Sign-Up: $e");
      return null;
    }
  }

  Future<void> signInWithGitHub() async {
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(githubProvider);

      Get.offAndToNamed(Routes.home);

      if (kDebugMode) {
        print("Successfully signed in as: ${userCredential.user?.displayName}");
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Firebase Auth Error: ${e.code} - ${e.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected error: $e");
      }
    }
  }
}
