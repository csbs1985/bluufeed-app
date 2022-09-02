import 'package:flutter/cupertino.dart';

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
}
