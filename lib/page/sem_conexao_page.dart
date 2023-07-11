import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/texto_text.dart';
import 'package:eight_app/theme/ui_imagem.dart';
import 'package:flutter/material.dart';

class SemConexaoPage extends StatelessWidget {
  const SemConexaoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height / 12),
                Image(
                  image: const AssetImage(UiImagem.erroResultado),
                  width: MediaQuery.sizeOf(context).width * 0.5,
                ),
                const SizedBox(height: 24),
                const TextoText(
                  texto: SEM_CONEXAO_POEMA,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
