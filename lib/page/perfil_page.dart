import 'package:bluufeed_app/appbar/simples_appbar.dart';
import 'package:bluufeed_app/button/botao_3d_button.dart';
import 'package:bluufeed_app/drawer/configuracao_drawer.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/separador_widget.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static const _marginPequena = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: SimplesAppbar(
          callback: () => scaffoldKey.currentState!.openEndDrawer()),
      endDrawer: const ConfiguracaoDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AvatarWidget(size: 70),
                        _marginPequena,
                        TituloText(
                          title:
                              // currentUsuario.value.nomeUsuario,
                              "Charles Santos",
                        ),
                        const TextoText(
                          texto:
                              // currentUsuario.value.email,
                              "charles.batista@gmail.com",
                        ),
                        const SizedBox(height: 24),
                        Botao3dButton(
                          callback: () => {},
                          texto: "seguindo",
                          largura: 100,
                        ),
                      ],
                    ),
                  ),
                  const SeparadorWidget(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TextoText(
                          texto: "Biografia",
                        ),
                        SizedBox(height: 16),
                        TextoText(
                          texto:
                              "A biografia é um gênero textual que relata a vida de uma pessoa importante e/ou conhecida socialmente, apresentando suas principais ações e experiências, bem como seus legados. O texto pode ser escrito em 1ª pessoa, a autobiografia, ou em 3ª pessoa, a biografia.",
                        ),
                      ],
                    ),
                  ),

                  const SeparadorWidget(),
                  const SizedBox(height: 24),
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
            ],
          ),
        ),
      ),
    );
  }
}
