import 'package:flutter/widgets.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const TextWidget(text: 'configuração'),
    );
  }
}
