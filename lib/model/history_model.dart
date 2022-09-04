import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/service/auth_service.dart';

ValueNotifier<List<HistoryModel>> currentHistory =
    ValueNotifier<List<HistoryModel>>([]);

class HistoryModel {
  late String id;
  late String title;
  late String text;
  late String date;
  late String userId;
  late String userName;
  late bool isComment;
  late bool isSigned;
  late bool isEdit;
  late bool isAuthorized;
  late int qtyComment;
  late List<String> categories;
  late List<String> bookmarks;

  HistoryModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.isComment,
    required this.isSigned,
    required this.isEdit,
    required this.isAuthorized,
    required this.userId,
    required this.userName,
    required this.qtyComment,
    required this.categories,
    required this.bookmarks,
  });

  factory HistoryModel.fromJson(json) => HistoryModel.fromMap(json);

  factory HistoryModel.fromMap(json) => HistoryModel(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        date: json['date'],
        isComment: json['isComment'],
        isSigned: json['isSigned'],
        isEdit: json['isEdit'],
        isAuthorized: json['isAuthorized'],
        userId: json['userId'],
        userName: json['userName'],
        qtyComment: json['qtyComment'],
        categories: json['categories'].cast<String>(),
        bookmarks: json['categories'].cast<String>(),
      );
}

class HistoryClass {
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();

  void add(Map<String, dynamic> history) {
    currentHistory.value = [];
    currentHistory.value.add(HistoryModel.fromJson(history));
  }

  Future<void> getHistory(String historyId) async {
    try {
      await historiesFirestore
          .getHistoryNotification(historyId)
          .then((result) => {
                add(result.docs[0].data()),
              });
    } on AuthException catch (error) {
      debugPrint('ERROR => _getHistory: $error');
    }
  }
}
