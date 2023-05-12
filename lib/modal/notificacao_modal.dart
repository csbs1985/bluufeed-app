import 'package:bluufeed_app/button/toggle_button.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class NotificacaoModal extends StatefulWidget {
  const NotificacaoModal({super.key});

  @override
  State<NotificacaoModal> createState() => _NotificacaoModalState();
}

class _NotificacaoModalState extends State<NotificacaoModal> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  bool _isNotificacao = currentUsuario.value.isNotificacao;

  _definirNotificacao() {
    setState(() => _isNotificacao = !_isNotificacao);
    _usuarioClass.pathNotificacao(_isNotificacao);
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
            direction: Axis.horizontal,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: TituloText(title: NOTIFICACAO),
                  ),
                  ToggleButton(
                    callback: (value) => _definirNotificacao(),
                    subtitulo: NOTIFICACAO,
                    resumo: NOTIFICACAO_TOGGLE,
                    value: _isNotificacao,
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
