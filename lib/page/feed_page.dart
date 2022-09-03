import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/app_bar_home_widget.dart';
import 'package:universe_history_app/widget/create_card_widget.dart';
import 'package:universe_history_app/widget/menu_widget.dart';
import 'package:universe_history_app/widget/separator_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AppBarHomeWidget(),
            SeparatorWidget(),
            CreateCardWidget(),
            MenuWidget(),
          ],
        ),
      ),
    );
  }
}
