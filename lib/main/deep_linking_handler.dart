import 'package:ElevatED/core/services/DeepLink%20services/deep_linking_service.dart';
import 'package:flutter/material.dart';

class AppDeepLinkHandler extends StatefulWidget {
  const AppDeepLinkHandler({super.key, required this.child});
  final Widget child;

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
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check for any pending deep links when app resumes
      DeepLinkService.checkInitialLink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


/*


Success: elevatedapp://payment-success?transaction_id=txn_123456&amount=99.99&timestamp=1640995200
Cancel: elevatedapp://payment-cancel?transaction_id=txn_123456&reason=user_cancelled
Failed: elevatedapp://payment-failed?transaction_id=txn_123456&error=insufficient_funds

 */