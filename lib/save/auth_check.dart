import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/page/loading_page.dart';
import 'package:bluuffed_app/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluuffed_app/page/home_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckServiceState();
}

class _AuthCheckServiceState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);

    if (_auth.isLoading)
      return const LoadingPage();
    else if (currentUser.value.isEmpty)
      return const LoginPage();
    else
      return const HomePage();
  }
}
