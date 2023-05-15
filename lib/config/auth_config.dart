import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/hive/usuario_hive.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthConfig extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ToastWidget _toastWidget = ToastWidget();
  final UsuarioClass _usuarioClass = UsuarioClass();
  final UsuarioHive _usuarioHive = UsuarioHive();

  User? usuario;

  bool isAuthenticated = false;

  AuthConfig() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isAuthenticated = user == null ? false : true;
      notifyListeners();
    });
  }

  verificarHive(BuildContext context) async {
    !_usuarioHive.verificarUsuario()
        ? await signIn(context)
        : _usuarioClass.verificarHive();
  }

  signIn(BuildContext context) async {
    await signInWithGoogle(context).then((User user) {
      Map<String, dynamic> userMap = _usuarioClass.userToMap(user);
      _usuarioClass.definirUsuario(userMap);
    } as Future Function(User? value));
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      usuario = userCredential.user;

      isAuthenticated = true;
      notifyListeners();
      return usuario;
    } on FirebaseAuthException {
      _toastWidget.toast(context, ToastEnum.ERRO, ERRO_ENTRAR);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await _usuarioClass.deleteUsuario();
    isAuthenticated = false;
    notifyListeners();
  }
}
