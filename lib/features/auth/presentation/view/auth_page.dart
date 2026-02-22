import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_firebase_authentication/common_ui/resource/my_assets.dart';
import 'package:flutter_firebase_authentication/core/status/base_status.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Spacer(),
            _title(),
            SizedBox(height: 32),
            _email(),
            SizedBox(height: 10),
            _password(),
            SizedBox(height: 15),
            _forgetPassword(),
            SizedBox(height: 62),
            _login(context),
            SizedBox(height: 16),
            _google(context),
            SizedBox(height: 16),
            _github(context),
            Spacer(),
            _register(),
            SizedBox(height: 26),
          ],
        ),
      ).paddingSymmetric(horizontal: 20),
    );
  }

  Widget _forgetPassword() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        overlayColor: Colors.transparent,
      ),
      onPressed: controller.goToForgotPassword,
      child: Text(
        'Forget Password?',
        style: GoogleFonts.urbanist(
          color: Colors.black54,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Welcome back! Glad\nto see you, Again!',
      style: GoogleFonts.urbanist(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _email() {
    return TextField(
      controller: controller.emailController,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: 'Enter Your Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _password() {
    return Obx(() {
      return TextField(
        controller: controller.passwordController,
        obscureText: !controller.showHidePassword.value,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          hintText: 'Enter your password',
          suffixIcon: IconButton(
            onPressed: controller.togglePassword,
            icon: controller.showHidePassword.value
                ? Icon(IconsaxOutline.eye_slash)
                : Icon(IconsaxOutline.eye),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    });
  }

  Widget _login(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.login,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Obx(
          () {
            if (controller.loginStatus.value is BaseLoading) {
              return CircularProgressIndicator.adaptive(backgroundColor: Colors.white);
            } else {
              return Text(
                'Login',
                style: GoogleFonts.urbanist(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _google(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.signInWithGoogle,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
            side: BorderSide(color: Colors.black12),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Row(
          spacing: 6,
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(MyAssets.googleSvg),
            Text(
              "Sign in with Google",
              style: GoogleFonts.urbanist(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _github(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.signInWithGitHub,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
            side: BorderSide(color: Colors.black12),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(MyAssets.githubSvg, width: 40,),
            Text(
              "Sign up with GitHub",
              style: GoogleFonts.urbanist(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _register() {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text('Don’t have an account? '),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
          ),
          onPressed: controller.goToRegister,
          child: Text(
            'Register Now',
            style: GoogleFonts.urbanist(
              color: Color(0XFF35C2C1),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
