// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final UserClass _userClass = UserClass();
  final UsersFirestore usersFirestore = UsersFirestore();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          await _userClass.readUser();
          await usersFirestore
              .getUserEmail(user.email)
              .then((result) => _userClass.add({
                    'id': result.docs[0]['id'],
                    'date': result.docs[0]['date'],
                    'name': result.docs[0]['name'],
                    'upDateName': result.docs[0]['upDateName'],
                    'status': result.docs[0]['status'],
                    'email': result.docs[0]['email'],
                    'token': result.docs[0]['token'],
                    'isNotification': result.docs[0]['isNotification'],
                    'qtyHistory': result.docs[0]['qtyHistory'],
                    'qtyComment': result.docs[0]['qtyComment'],
                  }));
        } on AuthException catch (error) {
          debugPrint('ERROR => getUserEmail: ' + error.toString());
        }
      }
      Navigator.of(context).pushNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: SvgPicture.asset(UiSvg.logo),
          ),
        ),
      ),
    );
  }
}
