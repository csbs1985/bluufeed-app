import 'package:flutter/cupertino.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);

class UserModel {
  late String id;
  late String name;
  late String upDateName;
  late String date;
  late String email;
  late String token;
  late String status;
  late bool isNotification;
  late num qtyHistory;
  late num qtyComment;

  UserModel({
    required this.id,
    required this.name,
    required this.upDateName,
    required this.date,
    required this.status,
    required this.email,
    required this.token,
    required this.isNotification,
    required this.qtyHistory,
    required this.qtyComment,
  });
}
