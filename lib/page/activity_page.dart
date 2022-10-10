import 'package:bluuffed_app/firestore/activity_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/skeleton/activity_skeleton.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/activity_item_widget.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (BuildContext context, value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: UiPadding.large),
                  child: Headline1(title: 'Atividades'),
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
