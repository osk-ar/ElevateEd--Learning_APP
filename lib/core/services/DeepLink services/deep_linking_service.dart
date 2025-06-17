import 'dart:async';
import 'dart:developer';

import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/init.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class DeepLinkService {
  static late final AppLinks _appLinks;
  static StreamSubscription<Uri>? _linkSubscription;

  static void initialize() {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      log("DeepLinkService: Stream Link Received - Full URI: ${uri.toString()}");
      log("DeepLinkService: Stream Link - Host: ${uri.host}, Path: ${uri.path}, Query: ${uri.query}");
      handleDeepLink(uri);
    });

    handleInitialLink();
  }

  static void handleInitialLink() async {
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        log("DeepLinkService: Initial Link Received - Full URI: ${initialLink.toString()}");
        log("DeepLinkService: Initial Link - Host: ${initialLink.host}, Path: ${initialLink.path}, Query: ${initialLink.query}");
        handleDeepLink(initialLink);
      }
    } catch (e) {
      log("DeepLinkService: Error in initial link: $e");
    }
  }

  static void handleDeepLink(Uri uri) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      log("DeepLinkService: Context is null, cannot navigate.");
      return;
    }

    log("DeepLinkService: Handling URI - Host: ${uri.host}, Path: ${uri.path}");

    // Add a guard to prevent re-navigation if already on the target screen
    // This requires knowing the current route or using a state management solution
    // For now, let's focus on the URI parsing.

    switch (uri.host) {
      case 'payment-success':
        log("DeepLinkService: Matched 'payment-success' host.");
        context.pushNamed(
          RouteConstants.paymentSuccessScreenRoute,
        );
        break;

      case 'payment-cancel':
        log("DeepLinkService: Matched 'payment-cancel' host.");
        context.pushNamed(
          RouteConstants.paymentCancelScreenRoute,
        );
        break;

      default:
        // This is the key insight from your updated log
        // The problematic URI ends up here because its host doesn't match 'payment-success' or 'payment-cancel'
        log("DeepLinkService: Unhandled host: '${uri.host}'. Attempting to handle by path or specific case.");

        // Check if the path is the root and it contains query parameters
        // This is where ' /?transaction_id=test123' would fall
        if (uri.path == '/' && uri.queryParameters.isNotEmpty) {
          log("DeepLinkService: Detected root path with query parameters. Ignoring as likely re-delivery of initial link.");
          // Do NOT navigate. This is the likely culprit of the unwanted push.
          // You might want to handle this explicitly if this is a valid scenario.
          // For now, we are preventing the `unDefinedRoute`
          return;
        }

        // If you have other specific deep link paths not based on host:
        // if (uri.path == '/some_other_path') {
        //   context.pushNamed('/some_other_path', arguments: uri.queryParameters);
        // } else {
        log("DeepLinkService: Fallback - No specific handling for this URI. Full URI: ${uri.toString()}");
        // If you still want to navigate to a default screen for truly unhandled links:
        // Navigator.of(context).pushNamed(RouteConstants.homeScreenRoute);
        // }
        break;
    }
  }

  static void dispose() {
    _linkSubscription?.cancel();
  }
}
