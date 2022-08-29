import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarBackComponent(),
      body: WebView(
        initialUrl: 'https://universe-history-web.web.app/politica-privacidade',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
