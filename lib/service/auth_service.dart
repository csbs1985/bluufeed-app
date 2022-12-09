import 'package:bluuffed_app/service/device_service.dart';
import 'package:bluuffed_app/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/token_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/email_service.dart';
import 'package:bluuffed_app/service/name_service.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class AuthService extends ChangeNotifier {
  final ActivityClass activityClass = ActivityClass();
  final DeviceService deviceService = DeviceService();
  final ToastWidget _toast = ToastWidget();
  final TokenFirestore _tokenFirestore = TokenFirestore();
  final UserFirestore _userFirestore = UserFirestore();
  final UserService _userService = UserService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late UserClass userClass = UserClass();

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

  getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await _auth.signOut();
    getUser();
  }

  delete() async {
    _auth.currentUser!.delete();
    getUser();
  }

  getToken() async {
    await _tokenFirestore
        .getToken()
        .then((String? result) => currentToken.value = result!)
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  getCurrentUser(String _activity) async {
    try {
      await getToken();
      await _userFirestore.getUserEmail(_auth.currentUser!.email!).then(
            (result) async => {
              _userService.setModelUser(result),
              await activityClass.save(
                type: _activity,
                content: deviceService.DeviceModel(),
              ),
            },
          );
      await _userFirestore.pathLoginLogout(UserStatusEnum.ACTIVE.value);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => setToken: $error');
    }
  }

  setCurrentUser(BuildContext context, String _activity) async {
    await getToken();

    _user = {
      'id': _auth.currentUser!.uid,
      'date': DateTime.now().toString(),
      'name': currentName.value,
      'bio': '',
      'upDateName': '',
      'status': UserStatusEnum.ACTIVE.value,
      'email': currentEmail.value,
      'token': currentToken.value,
      'isNotification': true,
      'qtyBookmark': 0,
      'qtyComment': 0,
      'qtyDenounce': 0,
      'qtyHistory': 0,
      'blocked': [],
      'following': [],
    };

    _userService.setCurrentUser(_user);

    _userFirestore.postUser(_user).then((result) async => {
          await activityClass.save(type: _activity),
        });
  }

  register(BuildContext context, String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await getUser();
      await setCurrentUser(context, ActivityEnum.NEW_ACCOUNT.name);
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
      await getUser();
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
          .then((_) => _toast.toast(
                context,
                ToastEnum.SUCCESS.value,
                'senha redefinida com sucesso',
              ));
    } catch (e) {
      _toast.toast(
          context, ToastEnum.WARNING.value, 'não foi possivél alterar a senha');
    }
  }
}
