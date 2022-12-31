import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/service/device_service.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class UserService {
  final ActivityClass activityClass = ActivityClass();
  final AuthService authService = AuthService();
  final DeviceService deviceService = DeviceService();
  final ToastWidget toast = ToastWidget();
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
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          await readUser();
          await _userFirestore
              .getUserEmail(currentEmail.value)
              .then((result) => setModelUser(result));
        } on AuthException catch (error) {
          debugPrint('ERROR => getUserEmail: ' + error.toString());
        }
      }
    });
  }

  void setCurrentUser(Map<String, dynamic> _user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(_user));
    saveUser(_user);
  }

  Future<File> saveUser(_user) async {
    // String data = UserModel.toJson(currentUser.value.first);
    final file = await getFileUser();
    return file.writeAsString(_user);
  }

  Future<String> readUser() async {
    final file = await getFileUser();
    return file.readAsString();
  }

  Future<File> getFileUser() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user.json');
  }

  Future<void> clean(BuildContext context) async {
    try {
      await _userFirestore.pathLoginLogout(UserStatusEnum.INACTIVE.value);
      await authService.logout();
      currentUser.value = [];
      Navigator.pop(context);
      toast.toast(
        context,
        ToastEnum.SUCCESS.value,
        'espero que isso não seja um adeus',
      );
      await activityClass.save(
        type: ActivityEnum.LOGOUT.value,
        elementId: '',
        content: deviceService.DeviceModel(),
      );
    } catch (error) {
      debugPrint('ERROR => _setUpQtyHistoryUser:$error');
      toast.toast(
        context,
        ToastEnum.WARNING.value,
        'não foi possível sair da aplicação no momento, tente novamente mais tarde',
      );
    }
  }

  Future<void> delete(BuildContext context) async {
    try {
      await _userFirestore.pathLoginLogout(UserStatusEnum.DELETED.name);
      await _userFirestore.deleteUser();
      await authService.delete();
      currentUser.value = [];
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteUser: $error');
      Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.WARNING.name,
        'não foi possível delatar a conta no momento, tente novamente mais tarde.',
      );
    }
  }

  bool isLogin() {
    return currentUser.value.isNotEmpty ? true : false;
  }
}
