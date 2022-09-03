// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:universe_history_app/firestore/activities_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

ActivityUtil(String type, String content, String elementId) async {
  final ActivitiesFirestore activitiesFirestore = ActivitiesFirestore();
  final Uuid uuid = Uuid();

  late Map<String, dynamic> _activity;

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

enum ActivitiesEnum {
  BLOCK_USER,
  DELETE_COMMENT,
  DELETE_HISTORY,
  DENOUNCE,
  LOGIN,
  LOGOUT,
  NEW_ACCOUNT,
  NEW_COMMENT,
  NEW_HISTORY,
  NEW_NICKNAME,
  TEMPORARILY_DISABLED,
  UP_COMMENT,
  UP_HISTORY,
  UP_NICKNAME,
  UP_NOTIFICATION,
  UNBLOCK_USER,
}
