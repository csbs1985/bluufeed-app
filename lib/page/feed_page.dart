import 'package:flutter/material.dart';
import 'package:universe_history_app/widget/home_header_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeHeaderWidget(),
            TextWidget(text: 'feed'),
          ],
        ),
      ),
    );
  }
}
