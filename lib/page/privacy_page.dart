import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(title: 'Termo de uso'),
      body: WebView(
        initialUrl: 'https://universe-history-web.web.app/politica-privacidade',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
