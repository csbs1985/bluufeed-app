import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/token_firestore.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/activity_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/email_service.dart';
import 'package:universe_history_app/service/name_service.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class AuthService extends ChangeNotifier {
  final ActivityClass activityClass = ActivityClass();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ToastWidget _toast = ToastWidget();

  late TokenFirestore tokenFirestore = TokenFirestore();
  late UserClass userClass = UserClass();
  late UserFirestore userFirestore = UserFirestore();

  String message = 'erro não classificado, tente novamente';

  User? user;
  String? token;
  bool isLoading = true;

  late Map<String, dynamic> _user;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    auth.authStateChanges().listen((User? _user) {
      user = (_user == null) ? null : _user;
      isLoading = false;
      notifyListeners();
    });
  }

  getUser() {
    user = auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await auth.signOut();
    getUser();
  }

  delete() async {
    auth.currentUser!.delete();
    getUser();
  }

  getToken() async {
    await tokenFirestore
        .getToken()
        .then((String? result) => token = result)
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  getCurrentUser(String _activity) async {
    await getToken();
    await userFirestore
        .getUserEmail(auth.currentUser!.email!)
        .then(
          (user) async => {
            userClass.add(
              {
                'id': user.docs[0]['id'],
                'date': user.docs[0]['date'],
                'name': user.docs[0]['name'],
                'upDateName': user.docs[0]['upDateName'],
                'status': UserStatusEnum.ACTIVE.value,
                'email': user.docs[0]['email'],
                'token': token,
                'isNotification': user.docs[0]['isNotification'],
                'qtyHistory': user.docs[0]['qtyHistory'],
                'qtyComment': user.docs[0]['qtyComment'],
              },
            ),
            await activityClass.save(type: _activity),
          },
        )
        .catchError((error) => debugPrint('ERROR => setToken:' + error));
  }

  setCurrentUser(BuildContext context, String _activity) async {
    await getToken();

    _user = {
      'id': auth.currentUser!.uid,
      'date': DateTime.now().toString(),
      'name': currentName.value,
      'upDateName': '',
      'status': UserStatusEnum.ACTIVE.value,
      'email': currentEmail.value,
      'token': token,
      'isNotification': true,
      'qtyHistory': 0,
      'qtyComment': 0,
    };

    userFirestore.postUser(_user).then((result) => {
          userClass.add(_user),
          Navigator.pushNamed(context, '/'),
        });
  }

  register(BuildContext context, String email, String senha) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: senha);
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
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      await getUser();
      await getCurrentUser(ActivityEnum.LOGIN.name);
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
}
