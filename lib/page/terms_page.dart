import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/app_bar_widget%20.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(isBack: true, title: 'Termo de uso'),
      body: WebView(
        initialUrl: 'https://universe-history-web.web.app/termo-uso',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
