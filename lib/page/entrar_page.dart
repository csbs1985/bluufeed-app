import 'package:bluufeed_app/class/auth_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntrarPage extends StatefulWidget {
  const EntrarPage({super.key});

  @override
  State<EntrarPage> createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  final AuthClass _authClass = AuthClass();

  signInWithGoogle(BuildContext context) async {
    await _authClass.signIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: SvgPicture.asset(UiSvg.logo)),
            Center(
              child: Text(
                ENTRAR_BEM_VINDO,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                ENTRAR_GOOGLE,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            IconButton(
              onPressed: () => signInWithGoogle(context),
              icon: SvgPicture.asset(UiSvg.google),
            )
          ],
        ),
      ),
    );
  }
}