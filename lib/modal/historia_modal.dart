import 'package:bluufeed_app/button/menu_button.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class HistoriaModal extends StatefulWidget {
  const HistoriaModal({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<HistoriaModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends State<HistoriaModal> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  bool? isUsuario;

  @override
  void initState() {
    super.initState();
    definirUsuario();
  }

  definirUsuario() {
    setState(() {
      isUsuario =
          widget._historia['idUsuario'] == currentUsuario.value.idUsuario
              ? true
              : false;
    });
  }

  editarHistoria(BuildContext context) {
    Navigator.of(context).pop();
    // context.pushNamed(RouteEnum.EDITAR_PERFIL.value,
    //     params: {'idUsuario': widget._historia['idUsuario']});
  }

  deletarHistoria() {
    Navigator.of(context).pop();
    print('deunciar');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? UiCor.mainEscuro : UiCor.main,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(UiBorda.arredondada),
              topRight: Radius.circular(UiBorda.arredondada),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubtituloText(subtitulo: HISTORIA_OPCOES),
                    const SizedBox(height: 24),
                    if (!isUsuario!) const TextoText(texto: HISTORIA_OPCAO_SEM),
                    if (isUsuario!)
                      MenuButton(
                        callback: () => editarHistoria(context),
                        resumo: HISTORIA_EDITAR_DESCRICAO,
                        subtitulo: HISTORIA_EDITAR,
                      ),
                    if (isUsuario!) const SizedBox(height: 8),
                    if (isUsuario!)
                      MenuButton(
                        callback: () => deletarHistoria(),
                        resumo: HISTORIA_DELETAR_DESCRICAO,
                        subtitulo: HISTORIA_DELETAR,
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
