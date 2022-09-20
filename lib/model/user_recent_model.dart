import 'package:flutter/cupertino.dart';

ValueNotifier<List<UserRecentModel>> currentUserRecent =
    ValueNotifier<List<UserRecentModel>>([]);

class UserRecentModel {
  late String id;
  late String name;

  UserRecentModel({
    required this.id,
    required this.name,
  });
}

class UserClass {
  add() {}
}
