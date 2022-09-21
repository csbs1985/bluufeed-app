import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bluuffed_app/firestore/histories_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/skeleton/history_item_skeleton.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/button_comment_widget.dart';
import 'package:bluuffed_app/widget/comment_list_widget.dart';
import 'package:bluuffed_app/widget/history_item_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryFirestore historyFirestore = HistoryFirestore();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
                elevation: 0,
                titleSpacing: 0,
                leading: IconButton(
                  icon: SvgPicture.asset(UiIcon.closed),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(UiIcon.option),
                    onPressed: () => {},
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: historyFirestore
                          .getHistory(currentHistory.value.first.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return _noResults();
                          case ConnectionState.waiting:
                            return HistoryItemSkeleton();
                          case ConnectionState.done:
                          default:
                            try {
                              Map<String, dynamic> _data =
                                  HistoryModel.toMap(snapshot.data!.docs[0]);
                              return HistoryItemWidget(snapshot: _data);
                            } catch (error) {
                              return _noResults();
                            }
                        }
                      },
                    ),
                    const CommentListWidget(),
                    if (currentHistory.value.first.isComment)
                      const SizedBox(height: UiSize.bottomNavigation)
                  ],
                ),
              ),
            ),
            if (currentHistory.value.first.isComment)
              const ButtonCommentWidget(),
          ],
        );
      },
    );
  }

  Widget _noResults() {
    return const NoResultWidget(
      text: 'História deletada ou não foi possível encontrar',
    );
  }
}
