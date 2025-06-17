import 'package:ElevatED/core/services/DeepLink%20services/deep_linking_service.dart';
import 'package:ElevatED/main/app.dart';
import 'package:flutter/material.dart';

class AppDeepLinkHandler extends StatefulWidget {
  const AppDeepLinkHandler({super.key});

  @override
  AppDeepLinkHandlerState createState() => AppDeepLinkHandlerState();
}

class AppDeepLinkHandlerState extends State<AppDeepLinkHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    DeepLinkService.initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    DeepLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}


/*


Success: elevatedapp://payment-success
Cancel: elevatedapp://payment-cancel
Failed: elevatedapp://payment-failed

 */