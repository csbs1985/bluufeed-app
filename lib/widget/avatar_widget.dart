import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/theme/ui_imagem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    required String avatar,
    double? size = 20,
  })  : _avatar = avatar,
        _size = size;

  final String _avatar;
  final double? _size;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  bool _isImagemAvatar = false;

  Future<void> _vedificarUrl() async {
    try {
      final response = await http.head(Uri.parse(widget._avatar));
      response.statusCode == 200;
      _isImagemAvatar = true;
    } catch (e) {
      _isImagemAvatar = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _vedificarUrl(),
      builder: (BuildContext context, _) {
        return ValueListenableBuilder(
          valueListenable: currentUsuario,
          builder: (BuildContext context, UsuarioModel usuario, _) {
            return _isImagemAvatar
                ? CircleAvatar(
                    radius: widget._size,
                    backgroundImage: NetworkImage(widget._avatar),
                  )
                : CircleAvatar(
                    radius: widget._size,
                    backgroundImage: const AssetImage(UiImagem.avatar),
                  );
          },
        );
      },
    );
  }
}
