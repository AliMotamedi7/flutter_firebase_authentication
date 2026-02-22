import 'package:flutter_firebase_authentication/common_ui/resource/my_assets.dart';
import 'package:flutter_firebase_authentication/core/status/base_status.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
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
            SizedBox(height: 16),
            _password(),
            SizedBox(height: 16),
            _confirmPassword(),
            SizedBox(height: 62),
            _login(context),
            SizedBox(height: 16),
            _google(context),
            Spacer(),
            _register(),
            SizedBox(height: 26),
          ],
        ),
      ).paddingSymmetric(horizontal: 20),
    );
  }

  Widget _title() {
    return Text(
      'Hello! Register to get\nstarted',
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
        obscureText: controller.showHidePassword.value,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    });
  }

  Widget _confirmPassword() {
    return TextField(
      obscureText: true,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: 'Confirm password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _login(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.createAccount,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Obx(
          () {
            if (controller.createAccountStatus.value is BaseLoading) {
              return CircularProgressIndicator.adaptive(backgroundColor: Colors.white);
            } else {
              return Text(
                'Register',
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
        onPressed: () {},
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
              "Sign up with Google",
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
        Text('Already have an account? '),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
          ),
          onPressed: controller.goToLogin,
          child: Text(
            'Login Now',
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
