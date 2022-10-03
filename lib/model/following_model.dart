import 'package:flutter/cupertino.dart';

ValueNotifier<bool> currentIsFollowing = ValueNotifier<bool>(false);

class FollowingModel {
  late String id;
  late String name;
  late String date;

  FollowingModel({
    required this.id,
    required this.name,
    required this.date,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) =>
      FollowingModel.fromMap(json);

  factory FollowingModel.fromMap(Map<String, dynamic> json) => FollowingModel(
        id: json['id'],
        name: json['name'],
        date: json['date'],
      );
}
