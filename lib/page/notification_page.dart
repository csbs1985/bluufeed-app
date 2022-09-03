import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Container(
        child: const TextWidget(text: 'notificação'),
      ),
    );
  }
}
