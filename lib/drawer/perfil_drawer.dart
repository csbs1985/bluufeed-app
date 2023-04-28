import 'package:bluufeed_app/class/auth_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';

class PerfilDrawer extends StatefulWidget {
  const PerfilDrawer({super.key});

  @override
  State<PerfilDrawer> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilDrawer> {
  final AuthClass _authClass = AuthClass();

  static const _marginPequena = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AvatarWidget(),
                  _marginPequena,
                  Text(
                    currentUsuario.value.nomeUsuario,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    currentUsuario.value.email,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  // ListView.builder(
                  //   itemCount: listaCategoria.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return TextButton(
                  //       onPressed: () => context.push(index.idCategoria),
                  //       style: ButtonStyle(
                  //           padding: MaterialStateProperty.all<EdgeInsets>(
                  //               const EdgeInsets.fromLTRB(0, 8, 16, 8))),
                  //       child: Text(
                  //         index.texto!,
                  //         style: Theme.of(context).textTheme.displayMedium,
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              GestureDetector(
                onTap: () => _authClass.signOut(),
                child: Text(
                  SAIR,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
