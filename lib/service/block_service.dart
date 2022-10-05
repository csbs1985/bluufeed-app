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

  final List _listBlocked = [];
  late Map<String, dynamic> _user;

  Iterable<BlockedModel>? _notResult;

  String getTextButton(Map<String, dynamic> _content) {
    if (_content['isSigned'] != null)
      return _content['isSigned']
          ? 'bloquear ${_content['userName'] ?? _content['name']}'
          : 'bloquear usuário';

    return 'bloquear ${_content['userName'] ?? _content['name']}';
  }

  bool isBlocked(String _idUser) {
    _notResult = currentUser.value.first.blocked
        .where((element) => element.idUser == _idUser);

    return _notResult!.isNotEmpty ? true : false;
  }

  postBlock(Map<String, dynamic> _content) {
    try {
      _user = {
        'idUser': _content['idUser'],
        'nameUser': _content['nameUser'],
        'date': DateTime.now().toString(),
        'isBlocker': true,
      };

      _listBlocked.add(_user);

      userFirestore.pathBlock(currentUser.value.first.id, _user);

      postBlock(_content);

      activityClass.save(
        type: ActivityEnum.BLOCK_USER.value,
        content: _content['name'],
        elementId: _content['idUser'],
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewHistory: $error');
    }
  }
}
