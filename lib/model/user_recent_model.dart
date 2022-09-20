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
  void add(Map<String, dynamic> user) {
    currentUserRecent.value.contains(user['id'])
        ? null
        : currentUserRecent.value.add(UserRecentModel.fromJson(user));
  }
}
