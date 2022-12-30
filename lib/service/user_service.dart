import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:flutter/cupertino.dart';

class UserService {
  final UserFirestore _userFirestore = UserFirestore();

  List<dynamic> _listUser = [];

  List<dynamic> algoliaToList(List<AlgoliaObjectSnapshot>? _list) {
    _listUser = [];

    for (var item in _list!)
      _listUser.add({
        'name': item.data['name'],
        'id': item.data['objectID'],
      });

    return _listUser;
  }

  void setModelUser(_value) {
    setCurrentUser({
      'id': _value.docs[0]['id'],
      'date': _value.docs[0]['date'],
      'name': _value.docs[0]['name'],
      'bio': _value.docs[0]['bio'],
      'upDateName': _value.docs[0]['upDateName'],
      'status': _value.docs[0]['status'],
      'email': _value.docs[0]['email'],
      'token': _value.docs[0]['token'],
      'isNotification': _value.docs[0]['isNotification'],
      'qtyBookmark': _value.docs[0]['qtyBookmark'],
      'qtyComment': _value.docs[0]['qtyComment'],
      'qtyDenounce': _value.docs[0]['qtyDenounce'],
      'qtyHistory': _value.docs[0]['qtyHistory'],
      'blocked': _value.docs[0]['blocked'],
      'following': _value.docs[0]['following'],
    });
  }

  initUser(BuildContext context) async {
    if (currentUser.value.isEmpty) {
      try {
        await _userFirestore
            .getUserEmail(currentEmail.value)
            .then((result) => setModelUser(result));
      } on AuthException catch (error) {
        debugPrint('ERROR => getUserEmail: ' + error.toString());
      }
    }
  }

  void setCurrentUser(Map<String, dynamic> _user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(_user));
  }
}
