import 'dart:async';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/init.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class DeepLinkService {
  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _linkSubscription;

  static void initialize() {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      handleDeepLink(uri);
    });

    // Check for initial link when app starts
    checkInitialLink();
  }

  static Future<void> checkInitialLink() async {
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        handleDeepLink(initialLink);
      }
    } catch (e) {
      print('Failed to get initial link: $e');
    }
  }

  static void handleDeepLink(Uri uri) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;

    switch (uri.path) {
      case '/payment-success':
        final transactionId = uri.queryParameters['transaction_id'];
        final amount = uri.queryParameters['amount'];
        context.pushNamed(
          '/payment-success',
          arguments: {
            'transaction_id': transactionId,
            'amount': amount,
          },
        );
        break;

      case '/payment-cancel':
        final reason = uri.queryParameters['reason'];
        context.pushNamed(
          '/payment-cancel',
          arguments: {'reason': reason},
        );
        break;
    }
  }

  static void dispose() {
    _linkSubscription?.cancel();
  }
}
