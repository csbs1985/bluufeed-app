// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:universe_history_app/firestore/activities_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class ActivityModal {}

class ActivityClass {
  final ActivitiesFirestore activitiesFirestore = ActivitiesFirestore();
  final Uuid uuid = Uuid();

  late Map<String, dynamic> _activity;

  save(String type, String content, String elementId) async {
    _activity = {
      'content': content.trim(),
      'date': DateTime.now().toString(),
      'elementId': elementId,
      'id': uuid.v4(),
      'type': type,
      'userId': currentUser.value.first.id,
    };

    await activitiesFirestore.postActivity(_activity);
  }
}

enum ActivityEnum {
  BLOCK_USER('/block_user'),
  DELETE_COMMENT('/delete_comment'),
  DELETE_HISTORY('/delete_history'),
  DENOUNCE('/denounce'),
  LOGIN('/login'),
  LOGOUT('/logout'),
  NEW_ACCOUNT('/new_account'),
  NEW_COMMENT('/new_comment'),
  NEW_HISTORY('/new_history'),
  NEW_NICKNAME('/new_nickname'),
  TEMPORARILY_DISABLED('/temporarily_disabled'),
  UP_COMMENT('/up_comment'),
  UP_HISTORY('/up_history'),
  UP_NICKNAME('/up_nickname'),
  UP_NOTIFICATION('/up_notification'),
  UNBLOCK_USER('/unblock_user');

  final String value;
  const ActivityEnum(this.value);
}
