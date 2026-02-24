import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/common_ui/resource/my_assets.dart';
import 'package:flutter_firebase_authentication/features/splash/presentation/controller/splash_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              MyAssets.bgImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: .end,
          crossAxisAlignment: .center,
          children: [
            SvgPicture.asset(MyAssets.logoSvg),
            SizedBox(
              height: 50
            ),
            CircularProgressIndicator.adaptive(),
            SizedBox(
              height: 50
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
