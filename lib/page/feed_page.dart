import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const TextWidget(text: 'feed'),
    );
  }
}
