import 'package:eight_app/appbar/voltar_appbar.dart';
import 'package:eight_app/button/menu_button.dart';
import 'package:eight_app/text/titulo_text.dart';
import 'package:flutter/material.dart';
import 'package:eight_app/class/perguntas_class.dart';

class PerguntasPage extends StatelessWidget {
  const PerguntasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TituloText(titulo: 'Perguntas frequentes'),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listaPerguntas.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: MenuButton(
                        callback: () => {},
                        subtitulo: listaPerguntas[index].pergunta,
                        resumo: listaPerguntas[index].resposta,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
