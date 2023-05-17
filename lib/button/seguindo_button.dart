import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/class/seguindo_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeguindoButton extends StatefulWidget {
  const SeguindoButton({
    super.key,
    required String idUsuario,
    required List<dynamic> listaUsuario,
  })  : _idUsuario = idUsuario,
        _listaUsuario = listaUsuario;

  final String _idUsuario;
  final List<dynamic> _listaUsuario;

  @override
  State<SeguindoButton> createState() => _SeguindoButtonState();
}

class _SeguindoButtonState extends State<SeguindoButton> {
  final SeguindoClass _seguindoClass = SeguindoClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  final double _eixo = 32.0;
  int _quantidade = 0;

  List<dynamic> _listaAvatar = [];

  Future<void>? _iniciarSeguindo() async {
    final elementos = widget._listaUsuario.take(5).toList();
    _quantidade = elementos.length;
    _listaAvatar = [];

    for (var item in elementos) {
      final _usuario = await _usuarioFirestore.getUsuarioId(item);
      _listaAvatar.add(_usuario.docs.first['avatarUsuario']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _iniciarSeguindo(),
      builder: (BuildContext context, _) {
        return ValueListenableBuilder(
          valueListenable: currentTema,
          builder: (BuildContext context, Brightness tema, _) {
            bool isDark = tema == Brightness.dark;

            return InkWell(
              onTap: () => context.pushNamed(RouteEnum.SEGUINDO.value,
                  params: {'idUsuario': widget._idUsuario}),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SubtituloText(subtitulo: SEGUINDO),
                    const SizedBox(height: 16),
                    if (_listaAvatar.isNotEmpty)
                      Row(
                        children: [
                          SizedBox(
                            width: _quantidade * _eixo +
                                (_quantidade > 0 ? (_eixo / 2) : 0),
                            height: 42,
                            child: Stack(
                              children: List.generate(
                                _listaAvatar.length,
                                (index) => Positioned(
                                  left: index * _eixo,
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor:
                                        isDark ? UiCor.mainEscuro : UiCor.main,
                                    child: AvatarWidget(
                                        avatar: _listaAvatar[index]),
                                  ),
                                ),
                              ).reversed.toList(),
                            ),
                          ),
                          TextoText(
                            texto: _seguindoClass
                                .textoSeguindoButton(widget._listaUsuario),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
