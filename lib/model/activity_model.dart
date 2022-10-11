import 'package:bluuffed_app/firestore/activity_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class ActivityModel {
  late String content;
  late String date;
  late String elementId;
  late String id;
  late String type;
  late String userId;

  ActivityModel({
    required this.content,
    required this.date,
    required this.elementId,
    required this.id,
    required this.type,
    required this.userId,
  });
}

class ActivityClass {
  final ActivityFirestore activityFirestore = ActivityFirestore();
  final Uuid uuid = const Uuid();

  late Map<String, dynamic> _activity;

  save({required String type, String? content, String? elementId}) async {
    _activity = {
      'content': content?.trim() ?? '',
      'date': DateTime.now().toString(),
      'elementId': elementId ?? '',
      'id': uuid.v4(),
      'type': type,
      'userId': currentUser.value.first.id,
    };

    await activityFirestore.postActivity(_activity);
  }
}

enum ActivityEnum {
  BLOCK_USER('block_user'),
  DELETE_COMMENT('delete_comment'),
  DELETE_HISTORY('delete_history'),
  DENOUNCE('denounce'),
  FOLLOWING('following'),
  LOGIN('login'),
  LOGOUT('logout'),
  NEW_ACCOUNT('new_account'),
  NEW_COMMENT('new_comment'),
  NEW_HISTORY('new_history'),
  NEW_NICKNAME('new_nickname'),
  TEMPORARILY_DISABLED('temporarily_disabled'),
  UP_COMMENT('up_comment'),
  UP_HISTORY('up_history'),
  UP_NICKNAME('up_nickname'),
  UP_NOTIFICATION('up_notification'),
  UP_BIOGRAPHY('up_biography'),
  UNBLOCK_USER('unblock_user');

  final String value;
  const ActivityEnum(this.value);
}
