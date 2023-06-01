import 'package:bluufeed_app/config/auth_config.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:bluufeed_app/button/3d_button.dart';
import 'package:flutter/material.dart';

class DeletarContaModal extends StatefulWidget {
  const DeletarContaModal({
    super.key,
    int? idJustificar,
  }) : _idJustificar = idJustificar;

  final int? _idJustificar;

  @override
  State<DeletarContaModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends State<DeletarContaModal> {
  final AuthConfig _authConfig = AuthConfig();

  bool? isUsuario;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            color: isDark ? UiCor.mainEscuro : UiCor.main,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(UiBorda.arredondada),
              topRight: Radius.circular(UiBorda.arredondada),
            ),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: SubtituloResumoText(
                  subtitulo: DELETAR,
                  resumo: DELETAR_DESCRICAO,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const TextoText(texto: CANCELAR),
                  ),
                  const SizedBox(width: 16),
                  Button3d(
                    width: 130,
                    height: UiTamanho.botaoPrincipal,
                    style: Button3dStyle(
                      topColor: UiCor.botao,
                      backColor: UiCor.botaoBorda,
                      tappedZ: 0,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                      z: 4,
                    ),
                    child: const Text(
                      DELETAR,
                      style: UiTexto.botao,
                    ),
                    onPressed: () =>
                        _authConfig.deletarConta(widget._idJustificar),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
