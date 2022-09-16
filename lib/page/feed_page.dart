import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/create_card_widget.dart';
import 'package:universe_history_app/widget/history_list_widget.dart';
import 'package:universe_history_app/widget/menu_widget.dart';
import 'package:universe_history_app/widget/separator_widget.dart';

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
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
            elevation: 0,
            leadingWidth: 100,
            leading: IconButton(
              padding: const EdgeInsets.only(left: UiPadding.large),
              icon: SvgPicture.asset(UiIcon.identity),
              onPressed: () => _scrollToTop(),
            ),
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
      },
    );
  }
}
