import 'package:eight_app/button/menu_button.dart';
import 'package:eight_app/class/rotas_class.dart';
import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/subtitulo_text.dart';
import 'package:eight_app/text/texto_text.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsuarioModal extends StatefulWidget {
  const UsuarioModal({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<UsuarioModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends State<UsuarioModal> {
  bool? isUsuario;

  @override
  void initState() {
    super.initState();
    definirUsuario();
  }

  definirUsuario() {
    setState(() {
      isUsuario = widget._usuario['idUsuario'] == currentUsuario.value.idUsuario
          ? true
          : false;
    });
  }

  editarPerfil(BuildContext context) {
    Navigator.of(context).pop();
    context.goNamed(RouteEnum.EDITAR_PERFIL.value,
        pathParameters: {'idUsuario': widget._usuario['idUsuario']});
  }

  denunciarUsuario() {
    Navigator.of(context).pop();
  }

  bloquearUsuario() {
    Navigator.of(context).pop();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Row(
                  children: [
                    AvatarWidget(
                      avatar: widget._usuario['avatarUsuario'],
                      size: 20,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextoText(texto: widget._usuario['nomeUsuario']),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubtituloText(subtitulo: USUARIO_OPCOES),
                    const SizedBox(height: 16),
                    if (isUsuario!)
                      MenuButton(
                        callback: () => editarPerfil(context),
                        resumo: HISTORIA_EDITAR_DESCRICAO,
                        subtitulo: USUARIO_EDITAR,
                      ),
                    if (!isUsuario!) const SizedBox(height: 8),
                    if (!isUsuario!)
                      MenuButton(
                        callback: () => denunciarUsuario(),
                        resumo: USUARIO_DENUNCIAR_DESCRICAO,
                        subtitulo: USUARIO_DENUNCIAR,
                      ),
                    if (!isUsuario!) const SizedBox(height: 8),
                    if (!isUsuario!)
                      MenuButton(
                        callback: () => bloquearUsuario(),
                        resumo: USUARIO_BLOQUEAR_DESCRICAO,
                        subtitulo: USUARIO_BLOQUEAR,
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
