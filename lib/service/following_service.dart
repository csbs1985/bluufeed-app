import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/comment_model.dart';
import 'package:bluuffed_app/model/following_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FollowingService {
  final ActivityClass activityClass = ActivityClass();
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toastWidget = ToastWidget();

  Iterable<FollowingModel>? _isNotEmpty;

  late Map<String, dynamic> _following;
  final List<Map<String, dynamic>> _listFallowing = [];

  bool isFollwing(String _idUser) {
    _isNotEmpty = currentUser.value.first.following
        .where((element) => element.id == _idUser);

    return _isNotEmpty!.isEmpty ? false : true;
  }

  toggleFollowing(BuildContext context, CommentModel _comment) {
    try {
      _following = {
        'id': _comment.userId,
        'name': _comment.userName,
        'date': DateTime.now().toString(),
      };

      _isNotEmpty!.isEmpty ? add(_following) : remove(_following);

      for (var item in currentUser.value.first.following) {
        _listFallowing.add({
          'id': item.id,
          'name': item.name,
          'date': item.date,
        });
      }

      userFirestore.pathFallowing(_listFallowing);

      activityClass.save(
        type: ActivityEnum.FOLLOWING.value,
        content: _comment.userName,
        elementId: _comment.userId,
      );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        _isNotEmpty!.isEmpty
            ? 'começou a seguir ${_comment.userName}'
            : 'deixou de seguir ${_comment.userName}',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory: $error');
    }
  }

  void add(Map<String, dynamic> _following) {
    currentUser.value.first.following.add(FollowingModel.fromJson(_following));
  }

  void remove(Map<String, dynamic> _following) {
    currentUser.value.first.following.removeWhere((item) {
      return item.id == _following['id'];
    });
  }

  List<FollowingModel> toModel(List<dynamic> following) {
    List<FollowingModel> _listFollowing = [];

    for (var item in following) {
      _listFallowing.add({
        'id': item['id'],
        'name': item['name'],
        'date': item['date'],
      });
    }

    return _listFollowing;
  }
}
