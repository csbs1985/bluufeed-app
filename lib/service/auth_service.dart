import 'package:bluuffed_app/service/device_service.dart';
import 'package:bluuffed_app/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/token_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

ValueNotifier<String> currentToken = ValueNotifier<String>('');

class AuthService extends ChangeNotifier {
  final ActivityClass activityClass = ActivityClass();
  final DeviceService deviceService = DeviceService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ToastWidget _toast = ToastWidget();
  final UserService _userService = UserService();

  late TokenFirestore tokenFirestore = TokenFirestore();
  late UserClass userClass = UserClass();
  late UserFirestore userFirestore = UserFirestore();

  String message = 'erro não classificado, tente novamente';

  User? user;

  bool isLoading = true;

  late Map<String, dynamic> _user;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? _user) {
      user = (_user == null) ? null : _user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  delete() async {
    _auth.currentUser!.delete();
    _getUser();
  }

  _getToken() async {
    await tokenFirestore
        .getToken()
        .then((String? result) => currentToken.value = result.toString())
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  getCurrentUser(String _activity) async {
    try {
      await userFirestore.getUserEmail(_auth.currentUser!.email!).then(
            (user) async => {
              _user = {
                'id': user.docs[0]['id'],
                'date': user.docs[0]['date'],
                'name': user.docs[0]['name'],
                'upDateName': user.docs[0]['upDateName'],
                'status': UserStatusEnum.ACTIVE.value,
                'email': user.docs[0]['email'],
                'token': currentToken.value,
                'isNotification': user.docs[0]['isNotification'],
                'qtyBookmark': user.docs[0]['qtyBookmark'],
                'qtyComment': user.docs[0]['qtyComment'],
                'qtyDenounce': user.docs[0]['qtyDenounce'],
                'qtyHistory': user.docs[0]['qtyHistory'],
                'blocked': user.docs[0]['blocked'],
                'following': user.docs[0]['following'],
              },
              _userService.add(_user),
              await activityClass.save(
                type: _activity,
                content: deviceService.DeviceModel(),
              ),
            },
          );
      await userFirestore.pathLoginLogout(UserStatusEnum.ACTIVE.value);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => setToken: $error');
    }
  }

  register(BuildContext context, String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await _getToken();
      await _userService.createUser(context, ActivityEnum.NEW_ACCOUNT.name);
      await _getUser();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          message = 'a senha é muito fraca';
          break;
        case 'email-already-in-use':
          message = 'este email já está cadastrado';
          break;
      }

      _toast.toast(context, ToastEnum.WARNING.value, message);
    }
  }

  login(BuildContext context, String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _getUser();
      await getCurrentUser(ActivityEnum.LOGIN.value);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'too-many-requests':
          message = 'erro na requisição, tente novamente mais tarde';
          break;
        case 'user-not-found':
          message = 'email informado não encontrado';
          break;
        case 'wrong-password':
          message = 'senha informada incorreta';
          break;
      }

      _toast.toast(context, ToastEnum.WARNING.value, message);
    }
  }

  changePassword(BuildContext context, String password) async {
    try {
      await _auth
          .confirmPasswordReset(code: 'code', newPassword: password)
          .then(
            (_) => _toast.toast(
              context,
              ToastEnum.SUCCESS.value,
              'senha redefinida com sucesso',
            ),
          );
    } catch (e) {
      _toast.toast(
          context, ToastEnum.WARNING.value, 'não foi possivél alterar a senha');
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
