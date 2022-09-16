import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/page/forgot_password_page.dart';
import 'package:universe_history_app/page/home_page.dart';
import 'package:universe_history_app/service/auth_service.dart';

class AuthCheckService extends StatefulWidget {
  const AuthCheckService({super.key});

  @override
  State<AuthCheckService> createState() => _AuthCheckServiceState();
}

class _AuthCheckServiceState extends State<AuthCheckService> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.user == null)
      return const ForgotPasswordPage();
    else
      return const HomePage();
  }

  Scaffold loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
