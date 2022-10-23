import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/service/name_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserService {
  final ActivityClass _activityClass = ActivityClass();
  final UserService _userService = UserService();
  late UserFirestore userFirestore = UserFirestore();
  late Map<String, dynamic> _user;
  List<dynamic> _listUser = [];

  createUser(BuildContext context, String _activity) async {
    AuthService _auth = Provider.of<AuthService>(context);
    await userFirestore.pathLoginLogout(UserStatusEnum.ACTIVE.value);

    _user = {
      'id': _auth.user!.uid,
      'date': DateTime.now().toString(),
      'name': currentName.value,
      'bio': '',
      'upDateName': '',
      'status': UserStatusEnum.ACTIVE.value,
      'email': currentEmail.value,
      'token': currentToken.value ?? '',
      'isNotification': true,
      'qtyBookmark': 0,
      'qtyComment': 0,
      'qtyDenounce': 0,
      'qtyHistory': 0,
      'blocked': [],
      'following': [],
    };
    _userService.add(_user);

    userFirestore.postUser(_user).then((result) async => {
          await _activityClass.save(type: _activity),
        });
  }

  List<dynamic> algoliaToList(List<AlgoliaObjectSnapshot>? _list) {
    _listUser = [];

    for (var item in _list!)
      _listUser.add({
        'name': item.data['name'],
        'id': item.data['objectID'],
      });

    return _listUser;
  }

  void add(Map<String, dynamic> user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(user));
  }
}
