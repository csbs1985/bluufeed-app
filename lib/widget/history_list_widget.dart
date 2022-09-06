import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/skeleton/history_item_skeleton.dart';
import 'package:universe_history_app/widget/history_item_widget.dart';
import 'package:universe_history_app/widget/no_result_widget.dart';

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({super.key});

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();

  @override
  void initState() {
    super.initState();

    _getContent();
  }

  _getContent() {
    String value = currentCategory.value.id!;

    if (value != CategoriesEnum.ALL.name &&
        value != CategoriesEnum.MY.name &&
        value != CategoriesEnum.SAVE.name) {
      return historiesFirestore.histories
          .orderBy('date')
          .where('categories', arrayContainsAny: [value]);
    }

    if (value == CategoriesEnum.MY.name) {
      return historiesFirestore.histories
          .orderBy('date')
          .where('userId', isEqualTo: currentUser.value.first.id);
    }

    if (value == CategoriesEnum.SAVE.name) {
      return historiesFirestore.histories
          .orderBy('date')
          .where('bookmarks', arrayContainsAny: [currentUser.value.first.id]);
    }

    return historiesFirestore.histories.orderBy('date');
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
              loadingBuilder: (context) => HistoryItemSkeleton(),
              errorBuilder: (context, error, _) =>
                  const NoResultWidget(text: 'Isso é tudo por enquanto.'),
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
