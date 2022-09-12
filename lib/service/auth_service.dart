import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/token_firestore.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ToastWidget _toast = ToastWidget();

  late TokenFirestore tokenFirestore = TokenFirestore();
  late UserClass userClass = UserClass();
  late UserFirestore userFirestore = UserFirestore();

  String message = 'erro não classificado, tente novamente';

  User? user;
  String? token;
  bool isLoading = true;

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
    await tokenFirestore
        .getToken()
        .then((String? result) => token = result)
        .catchError((error) => debugPrint('ERROR => getToken:' + error));
  }

  setToken() async {
    await getToken();
    await userFirestore
        .getUserEmail(_auth.currentUser!.email!)
        .then((user) async => {
              userClass.add({
                'id': user.docs[0]['id'],
                'date': user.docs[0]['date'],
                'name': user.docs[0]['name'],
                'upDateName': user.docs[0]['upDateName'],
                'status': UserStatusEnum.ACTIVE.name,
                'email': user.docs[0]['email'],
                'token': token,
                'isNotification': user.docs[0]['isNotification'],
                'qtyHistory': user.docs[0]['qtyHistory'],
                'qtyComment': user.docs[0]['qtyComment'],
              }),
              if (token != null && currentUser.value.isNotEmpty)
                await userFirestore.pathLoginLogout(
                  UserStatusEnum.ACTIVE.name,
                  token: token,
                )
            })
        .catchError((error) => debugPrint('ERROR => setToken:' + error));
  }

  register(BuildContext context, String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await getUser();
      // await getToken();
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
      getUser();
      setToken();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'too-many-requests':
          message = 'tente novamente mais tarde';
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
