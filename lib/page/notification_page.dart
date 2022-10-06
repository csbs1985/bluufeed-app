import 'package:bluuffed_app/firestore/notifications_firestore.dart';
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
  final NotificationFirestore notificationFirestore = NotificationFirestore();

  late bool isDark;

  Color _getColor(item) {
    if (item['view']) return isDark ? UiColor.mainDark : UiColor.main;
    return isDark ? UiColor.backDark : UiColor.back;
  }

  Future<void> _pathNotificationView(_history) async {
    currentNotification.value = false;
    if (!_history['view']) {
      try {
        await notificationFirestore.pathNotificationView(_history['id']);

        setState(() => _history['view'] = true);
      } on FirebaseAuthException catch (error) {
        debugPrint('ERROR => pathNotificationView: ' + error.toString());
      }
    }

    Navigator.pushNamed(
      context,
      PageEnum.HISTORY.value,
      arguments: _history['contentId'],
    );
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
                  itemBuilder: (BuildContext context,
                      QueryDocumentSnapshot<dynamic> snapshot) {
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
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: _getColor(_item),
            child: _NotificationItem(_item),
          ),
          const BorderWidget()
        ],
      ),
      onTap: () => _pathNotificationView(_item),
    );
  }

  Widget _NotificationItem(Map<String, dynamic> _item) {
    String _getText() {
      if (_item['status'] == NotificationEnum.COMMENT_ANONYMOUS.value &&
          _item['content'] == '')
        return 'Uma de suas histórias recebeu um comentário "<bold>anônimo</bold>".';

      if (_item['status'] == NotificationEnum.COMMENT_ANONYMOUS.value &&
          _item['content'] != '')
        return 'Sua história <bold>${_item['content']}</bold> recebeu um comentário "<bold>anônimo</bold>".';

      if (_item['status'] == NotificationEnum.COMMENT_SIGNED.value &&
          _item['content'] == '')
        return '<bold>${_item['userName']}</bold> fez um comentou em uma de suas histórias.';

      if (_item['status'] == NotificationEnum.COMMENT_SIGNED.value &&
          _item['content'] != '')
        return '<bold>${_item['userName']}</bold> fez um comentou na história <bold>${_item['content']}</bold>';

      return '<bold>${_item['userName']}</bold> compartilhou uma história com você.';
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
