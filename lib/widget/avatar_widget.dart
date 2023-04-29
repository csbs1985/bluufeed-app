import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/theme/ui_imagem.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    String? avatar,
    double? size = 24,
  })  : _avatar = avatar,
        _size = size;

  final String? _avatar;
  final double? _size;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUsuario,
      builder: (BuildContext context, UsuarioModel? usuario, _) {
        return currentUsuario.value.avatarUsuario == ""
            ? CircleAvatar(
                radius: widget._size,
                backgroundImage: const AssetImage(UiImagem.avatar))
            : CircleAvatar(
                radius: widget._size,
                backgroundImage: NetworkImage(
                  widget._avatar != null
                      ? widget._avatar!
                      : usuario!.avatarUsuario,
                ),
              );
      },
    );
  }
}
