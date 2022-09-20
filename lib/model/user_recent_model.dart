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

  factory UserRecentModel.fromJson(Map<String, dynamic> json) =>
      UserRecentModel.fromMap(json);

  factory UserRecentModel.fromMap(Map<String, dynamic> json) => UserRecentModel(
        id: json['id'],
        name: json['name'],
      );
}

class UserRecentClass {
  add(Map<String, dynamic> user) {
    bool _contain = false;

    for (var item in currentUserRecent.value)
      _contain = (item.id == user['id']) ? true : false;

    if (!_contain) currentUserRecent.value.add(UserRecentModel.fromJson(user));
  }
}
