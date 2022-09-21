import 'package:bluuffed_app/firestore/activity_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/skeleton/activity_skeleton.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/activity_item_widget.dart';
import 'package:bluuffed_app/widget/app_bar_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ActivityFirestore activityFirestore = ActivityFirestore();
  final UserFirestore userFirestore = UserFirestore();

  String _qtyHistory = 'nenhuma história';
  String _qtyComment = 'nenhum comentário';

  _getResume() {
    userFirestore.getUserEmail(currentUser.value.first.email).then((result) => {
          if (result.docs.first['qtyHistory'] == 1) _qtyHistory = '1 história',
          if (result.docs.first['qtyHistory'] > 1)
            _qtyHistory = '${result.docs.first['qtyHistory']} histórias',
          if (result.docs.first['qtyComment'] == 1)
            _qtyComment = '1 comentário',
          if (result.docs.first['qtyComment'] > 1)
            _qtyComment = '${result.docs.first['qtyComment']} comentários',
        });

    return _qtyHistory + ' · ' + _qtyComment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Atividades'),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (BuildContext context, value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    UiPadding.large,
                    0,
                    UiPadding.large,
                    UiPadding.medium,
                  ),
                  child: SubtitleResumeWidget(
                    title: 'Suas atividades',
                    resume: _getResume(),
                  ),
                ),
                FirestoreListView(
                  query: activityFirestore.activities
                      .orderBy('date', descending: true)
                      .where('userId', isEqualTo: currentUser.value.first.id),
                  pageSize: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  loadingBuilder: (context) => const ActivitySkeleton(),
                  errorBuilder: (context, error, stackTrace) =>
                      const NoResultWidget(
                    text: 'Não há atividades ou não foi possível encontrá-las.',
                  ),
                  itemBuilder: (
                    BuildContext context,
                    QueryDocumentSnapshot<dynamic> snapshot,
                  ) {
                    Map<String, dynamic> _item = snapshot.data();
                    return ActivityItemWidget(snapshot: _item);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
