import 'package:flutter_firebase_authentication/features/home/presentation/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            _logout(context),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return SizedBox(
      height: 56,
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: controller.logOut,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.black,
          alignment: Alignment.center,
          elevation: 0,
        ),
        child: Text(
          "Logout",
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
