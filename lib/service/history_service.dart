import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:flutter/cupertino.dart';

class HistoryService {
  final HistoryFirestore historyFirestore = HistoryFirestore();

  Future<void> pathAllHistory() async {
    await historyFirestore
        .getAllHistoryUser()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await historyFirestore.pathNameUserHistory(item['id']),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }
}
