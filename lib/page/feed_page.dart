import 'package:bluuffed_app/widget/app_bar_home_widget.dart';
import 'package:bluuffed_app/widget/history_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/widget/create_card_widget.dart';
import 'package:bluuffed_app/widget/menu_widget.dart';
import 'package:bluuffed_app/widget/separator_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeWidget(
        callback: (value) => _scrollToTop(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: const [
            MenuWidget(),
            CreateCardWidget(),
            SeparatorWidget(),
            HistoryListWidget(),
          ],
        ),
      ),
    );
  }
}
