import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/model/category_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/skeleton/history_item_skeleton.dart';
import 'package:bluuffed_app/widget/history_item_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({super.key});

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  final HistoryFirestore historyFirestore = HistoryFirestore();

  @override
  void initState() {
    super.initState();

    _getContent();
  }

  _getContent() {
    String _category = currentCategory.value.id!;

    if (_category != CategoryEnum.ALL.value &&
        _category != CategoryEnum.MY.value &&
        _category != CategoryEnum.SAVE.value) {
      return historyFirestore.stories
          .orderBy('date')
          .where('categories', arrayContainsAny: [_category]);
    }

    if (_category == CategoryEnum.MY.value) {
      return historyFirestore.stories
          .orderBy('date')
          .where('userId', isEqualTo: currentUser.value.first.id);
    }

    if (_category == CategoryEnum.SAVE.value) {
      return historyFirestore.stories
          .orderBy('date')
          .where('bookmarks', arrayContainsAny: [currentUser.value.first.id]);
    }

    return historyFirestore.stories.orderBy('date');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoryModel>(
      valueListenable: currentCategory,
      builder: (BuildContext context, value, __) {
        return Column(
          children: [
            FirestoreListView(
              query: _getContent(),
              pageSize: 10,
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const HistoryItemSkeleton(),
              errorBuilder: (context, error, _) => const HistoryItemSkeleton(),
              itemBuilder: (BuildContext context,
                  QueryDocumentSnapshot<dynamic> snapshot) {
                return HistoryItemWidget(snapshot: snapshot.data());
              },
            ),
            const NoResultWidget(text: 'Isso é tudo por enquanto.'),
          ],
        );
      },
    );
  }
}
