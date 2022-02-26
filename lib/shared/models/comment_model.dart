// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';

ValueNotifier<num> currentQtyComment = ValueNotifier(0);

class CommentModel {
  final String date;
  final String historyId;
  final String text;
  final String userId;
  final String userNickName;
  final bool isAnonymous;
  final bool isEdit;

  CommentModel({
    required this.date,
    required this.historyId,
    required this.isAnonymous,
    required this.isEdit,
    required this.text,
    required this.userId,
    required this.userNickName,
  });

  CommentModel.fromJson(Map<CommentModel, dynamic> json)
      : date = json['date'],
        historyId = json['historyId'],
        isAnonymous = json['isAnonymous'],
        isEdit = json['isEdit'],
        text = json['text'],
        userId = json['userId'],
        userNickName = json['userNickName'];

  Map<String, dynamic> toJson() => {
        'date': date,
        'historyId': historyId,
        'isAnonymous': isAnonymous,
        'isEdit': isEdit,
        'text': text,
        'userId': userId,
        'userNickName': userNickName,
      };
}

class CommentClass {
  void setQtyComment(num qty) {
    currentQtyComment.value = qty;
  }
}
