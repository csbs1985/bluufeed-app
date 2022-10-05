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

  factory FollowingModel.fromMap(Map<String, dynamic> json) => FollowingModel(
        id: json['id'],
        name: json['name'],
        date: json["date"],
      );

  Map<String, dynamic> toMap(FollowingModel user) => {
        'id': user.id,
        'name': user.name,
        'date': user.date,
      };
}
