import 'package:bluuffed_app/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluuffed_app/page/home_page.dart';
import 'package:bluuffed_app/service/auth_service.dart';

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
      return const LoginPage();
    else
      return const HomePage();
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
