import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/core/status/base_status.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationPasswordPage extends GetView<AuthController> {
  const EmailVerificationPasswordPage({super.key});

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
            SizedBox(height: 32),
            _title(),
            SizedBox(height: 10),
            _description(),
            SizedBox(height: 32),
            _email(),
            SizedBox(height: 38),
            _login(context),
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
      'Forgot Password?',
      style: GoogleFonts.urbanist(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return Text(
      'Please enter the email address linked with your account.',
      style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 16),
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

  Widget _login(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.sendPasswordResetEmail,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Obx(
              () {
            if (controller.emailVerificationPasswordStatus.value is BaseLoading) {
              return CircularProgressIndicator.adaptive(backgroundColor: Colors.white);
            } else {
              return Text(
                'Send Code',
                style: GoogleFonts.urbanist(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _register() {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text('Remember Password?'),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
          ),
          onPressed: controller.goToLogin,
          child: Text(
            'Login',
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
