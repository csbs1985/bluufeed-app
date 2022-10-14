import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/blocked_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class BlockService {
  final ActivityClass activityClass = ActivityClass();
  final UserFirestore userFirestore = UserFirestore();
  final ToastWidget toastWidget = ToastWidget();

  late Map<String, dynamic> _block;

  Iterable<BlockedModel>? _notResult;

  String getTextButton(Map<String, dynamic> _content) {
    if (_content['isSigned'] != null)
      return _content['isSigned']
          ? 'bloquear ${_content['userName'] ?? _content['name']}'
          : 'bloquear usuário';

    return 'bloquear ${_content['userName'] ?? _content['name']}';
  }

  bool isBlocked(String _userId) {
    _notResult = currentUser.value.first.blocked
        .where((element) => element.blockedUserId == _userId);

    return _notResult!.isNotEmpty ? true : false;
  }

  postBlock(BuildContext context, Map<String, dynamic> _content) {
    try {
      _block = {
        'blockedUserId': _content['userId'],
        'blockedUserName': _content['userName'],
        'date': DateTime.now().toString(),
        'blockingUser': currentUser.value.first.id,
      };

      userFirestore.postBlockedUser(_block);
      userFirestore.postBlockingUser(_block);

      activityClass.save(
        type: ActivityEnum.BLOCK_USER.value,
        content: _block['blockedUserName'],
        elementId: _block['date'],
      );

      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'usuário bloqueado',
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory: $error');
    }
  }
}
