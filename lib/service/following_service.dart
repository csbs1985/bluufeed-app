import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/following_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FollowingService {
  final ActivityClass activityClass = ActivityClass();
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toastWidget = ToastWidget();

  Iterable<FollowingModel>? _notResult;

  final List _listFollowing = [];

  String message = '';

  bool isFollowing(String _idUser) {
    _notResult = currentUser.value.first.following
        .where((element) => element.id == _idUser);

    return _notResult!.isNotEmpty ? true : false;
  }

  String isFollwingButton(Map<String, dynamic> _user) {
    return isFollowing(_user['userId'])
        ? 'deixar de seguir ${_user['userName']}'
        : 'seguir ${_user['userName']}';
  }

  toggleFollowing(BuildContext context, _content) {
    try {
      if (isFollowing(_content['id'])) {
        _listFollowing.remove(_content);
        message = 'deixou de seguir ${_content['name']}';
      } else {
        _listFollowing.add(_content);
        message = 'começou a seguir ${_content['name']}';
      }

      for (var item in currentUser.value.first.following) {
        _listFollowing.add({
          'id': item.id,
          'name': item.name,
          'date': item.date,
        });
      }

      userFirestore.pathFallowing(_listFollowing);

      activityClass.save(
        type: ActivityEnum.FOLLOWING.value,
        content: _content['name'],
        elementId: _content['id'],
      );

      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        message,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory: $error');
    }
  }

  void add(Map<String, dynamic> _following) {
    currentUser.value.first.following.add(FollowingModel.fromMap(_following));
  }

  void remove(Map<String, dynamic> _following) {
    currentUser.value.first.following.removeWhere((item) {
      return item.id == _following['id'];
    });
  }
}
