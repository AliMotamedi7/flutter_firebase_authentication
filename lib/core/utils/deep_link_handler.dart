import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_firebase_authentication/core/router/routes.dart';

class DeepLinkHandler {
  DeepLinkHandler._internal();

  static final DeepLinkHandler instance = DeepLinkHandler._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  Future<void> initDeepLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handlePasswordResetLink(initialUri);
    }

    _sub?.cancel();
    _sub = _appLinks.uriLinkStream.listen((Uri uri) {
      _handlePasswordResetLink(uri);
    });
  }

  void dispose() {
    _sub?.cancel();
    _sub = null;
  }

  void _handlePasswordResetLink(Uri uri) {
    String? innerLink = uri.queryParameters['link'];

    Uri effectiveUri = uri;

    if (innerLink != null) {
      try {
        effectiveUri = Uri.parse(innerLink);
      } catch (e) {
        debugPrint("Error parsing inner link: $e");
      }
    }

    final mode = effectiveUri.queryParameters['mode'];
    final code = effectiveUri.queryParameters['oobCode'];

    debugPrint("Deep Link Received: $uri");
    debugPrint("Effective URI: $effectiveUri");
    debugPrint("Mode: $mode, Code: $code");

    if (mode == 'resetPassword' && code != null) {
      Get.toNamed(Routes.resetPassword, arguments: code);
    }
  }
}
