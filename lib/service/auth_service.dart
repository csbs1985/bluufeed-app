import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/token_firestore.dart';
import 'package:universe_history_app/firestore/user_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  late TokenFirestore tokenFirestore = TokenFirestore();
  late UserClass userClass = UserClass();
  late UserFirestore userFirestore = UserFirestore();

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  registerAuthentication(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await getUser();
      await getToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('a senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('este email já está cadastrado');
      }
    }
  }

  loginAuthentication(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await getUser();
      await setToken();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('email não encontrado. cadastre-se');
      } else if (e.code == 'wrong-password') {
        throw AuthException('senha incorreta. tente novamente');
      }
    }
  }
}
