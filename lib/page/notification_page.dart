import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/firestore/notifications_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/date_service.dart';
import 'package:bluuffed_app/service/push_notification_service.dart';
import 'package:bluuffed_app/skeleton/notification_skeleton.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/date_widget.dart';
import 'package:bluuffed_app/widget/notification_icon_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:styled_text/styled_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final NotificationFirestore notificationFirestore = NotificationFirestore();

  late bool isDark;

  late Map<String, dynamic> _history;

  Color _getColor(item) {
    if (item['view']) return isDark ? UiColor.mainDark : UiColor.main;
    return isDark ? UiColor.backDark : UiColor.back;
  }

  Future<void> _pathNotificationView(_notification) async {
    currentNotification.value = false;
    if (!_notification['view']) {
      try {
        await notificationFirestore.pathNotificationView(_notification['id']);

        _notification['view'] = true;
      } on FirebaseAuthException catch (error) {
        debugPrint('ERROR => pathNotificationView: ' + error.toString());
      }
    }

    await _getHistory(_notification['contentId']);

    Navigator.pushNamed(context, PageEnum.HISTORY.value);
  }

  _getHistory(String _historyId) async {
    try {
      await historyFirestore.getHistory(_historyId).then(
            (result) => {
              _history = {
                'id': result.docs[0]['id'],
                'title': result.docs[0]['title'],
                'text': result.docs[0]['text'],
                'date': result.docs[0]['date'],
                'isComment': result.docs[0]['isComment'],
                'isSigned': result.docs[0]['isSigned'],
                'isEdit': result.docs[0]['isEdit'],
                'isAuthorized': result.docs[0]['isAuthorized'],
                'qtyComment': result.docs[0]['qtyComment'],
                'categories': result.docs[0]['categories'],
                'userId': result.docs[0]['userId'],
                'userName': result.docs[0]['userName'],
                'bookmarks': result.docs[0]['bookmarks'],
              },
              historyClass.add(_history),
            },
          );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => getHistory: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      body: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          isDark = currentTheme.value == Brightness.dark;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: UiPadding.large),
                  child: Headline1(title: 'Notificações'),
                ),
                FirestoreListView(
                  query: notificationFirestore.notifications
                      .orderBy('date')
                      .where('userId', isEqualTo: currentUser.value.first.id),
                  pageSize: 10,
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  loadingBuilder: (context) => const NotificationSkeleton(),
                  errorBuilder: (context, error, _) => const NoResultWidget(
                    text: 'Não há ou não encontramos notificações no momento.',
                  ),
                  itemBuilder: (
                    BuildContext context,
                    QueryDocumentSnapshot<dynamic> snapshot,
                  ) {
                    final Map<String, dynamic> _item = snapshot.data();

                    return _notificationList(_item);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _notificationList(Map<String, dynamic> _item) {
    return TextButton(
      onPressed: () => _pathNotificationView(_item),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: _getColor(_item),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: UiPadding.large,
              vertical: UiPadding.small,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NotificationIconWidget(item: _item['status']),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: SizedBox(
                    width: double.infinity,
                    child: _NotificationItem(_item),
                  ),
                ),
              ],
            ),
          ),
          const BorderWidget()
        ],
      ),
    );
  }

  Widget _NotificationItem(Map<String, dynamic> _item) {
    String _getText() {
      if (_item['status'] == NotificationEnum.COMMENT_ANONYMOUS.value)
        return 'Sua história <bold>${_item['content']}</bold> recebeu um comentário "<bold>anônimo</bold>".';

      if (_item['status'] == NotificationEnum.COMMENT_SIGNED.value)
        return '<bold>${_item['userName']}</bold> fez um comentou na história <bold>${_item['content']}</bold>';

      return '<bold>${_item['userName']}</bold> compartilhou a história <bold>${_item['content']}</bold> com você.';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: UiPadding.large,
        vertical: UiPadding.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(
            text: _getText(),
            style: Theme.of(context).textTheme.headline2,
            tags: {
              'bold': StyledTextTag(
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            },
          ),
          const SizedBox(height: UiPadding.small),
          DateWidget(
            type: DateEnum.ACTIVITY.value,
            item: _item,
          ),
        ],
      ),
    );
  }
}
