import 'package:bluuffed_app/model/blocked_model.dart';
import 'package:bluuffed_app/model/following_model.dart';
import 'package:bluuffed_app/service/block_service.dart';
import 'package:bluuffed_app/service/following_service.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);
ValueNotifier<String> currentUserId = ValueNotifier<String>('');
ValueNotifier<String> currentToken = ValueNotifier<String>('');

final BlockService blockService = BlockService();
final FollowingService followingService = FollowingService();

class UserModel {
  late String id;
  late String name;
  late String bio;
  late String upDateName;
  late String date;
  late String email;
  late String token;
  late String status;
  late bool isNotification;
  late num qtyBookmark;
  late num qtyComment;
  late num qtyDenounce;
  late num qtyHistory;
  final List<BlockedModel> blocked;
  final List<FollowingModel> following;

  UserModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.upDateName,
    required this.date,
    required this.status,
    required this.email,
    required this.token,
    required this.isNotification,
    required this.qtyBookmark,
    required this.qtyComment,
    required this.qtyDenounce,
    required this.qtyHistory,
    required this.blocked,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        bio: json['bio'],
        upDateName: json['upDateName'],
        date: json["date"],
        email: json['email'],
        token: json['token'],
        status: json['status'],
        isNotification: json['isNotification'],
        qtyBookmark: json['qtyBookmark'],
        qtyComment: json['qtyComment'],
        qtyDenounce: json['qtyDenounce'],
        qtyHistory: json['qtyHistory'],
        blocked: (json['blocked'] as List)
            .map((e) => BlockedModel.fromMap(e))
            .toList(),
        following: (json['following'] as List)
            .map((e) => FollowingModel.fromMap(e))
            .toList(),
      );

  Map<String, dynamic> toJson(UserModel user) => {
        'id': user.id,
        'name': user.name,
        'bio': user.bio,
        'upDateName': user.upDateName,
        'date': user.date,
        'email': user.email,
        'token': user.token,
        'isNotification': user.isNotification,
        'status': user.status,
        'qtyBookmark': user.qtyBookmark,
        'qtyComment': user.qtyComment,
        'qtyDenounce': user.qtyDenounce,
        'qtyHistory': user.qtyHistory,
        'blocked': user.blocked,
        'following': user.following,
      };
}

enum UserStatusEnum {
  ACTIVE('active'),
  INACTIVE('inactive'),
  DISABLED('disabled'),
  DELETED('deleted');

  final String value;
  const UserStatusEnum(this.value);
}
