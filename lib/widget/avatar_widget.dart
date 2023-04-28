import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/theme/ui_imagem.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    double? size = 24,
  }) : _size = size;

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
        return usuario!.avatar.isNotEmpty
            ? CircleAvatar(
                radius: widget._size,
                backgroundImage: NetworkImage(usuario.avatar))
            : CircleAvatar(
                radius: widget._size,
                backgroundImage: const AssetImage(UiImagem.avatar));
      },
    );
  }
}
