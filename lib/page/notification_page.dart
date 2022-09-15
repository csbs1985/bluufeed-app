import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/app_bar_not_back_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarNotBackWidget(title: 'Notificações'),
    );
  }
}
