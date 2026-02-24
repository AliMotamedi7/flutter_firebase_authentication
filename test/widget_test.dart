import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_firebase_authentication/features/auth/presentation/view/auth_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// IMPORTANT: Import the file where your login screen widget lives
// import 'package:your_app_name/login_screen.dart'; 

void main() {
  testWidgets('Sign in with Google button renders on the screen', (WidgetTester tester) async {

    // 1. Build our app and trigger a frame.
    // We wrap your screen in a MaterialApp (or GetMaterialApp since you use GetX) 
    // so it has the proper visual context to render text and buttons.
    Get.put(AuthController());
    await tester.pumpWidget(
      const MaterialApp(
        home: AuthPage(),
      ),
    );

    // 2. Wait for all animations and rendering to finish
    await tester.pumpAndSettle();

    // 3. Search the screen for the exact text on your button
    // (Make sure this string exactly matches the text in your app!)
    final googleButtonFinder = find.text('Sign in with Google');

    // 4. Assert that the tester found exactly one widget with this text
    expect(googleButtonFinder, findsOneWidget);
  });
}