import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarBackComponent(),
      body: WebView(
        initialUrl: 'https://universe-history-web.web.app/termo-uso',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
