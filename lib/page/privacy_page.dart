import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarBackWidget(),
      body: WebView(
        initialUrl: 'https://bluufeed.com/privacy',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
