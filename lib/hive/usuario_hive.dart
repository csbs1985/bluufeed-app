import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsuarioHive {
  final _usuarioBox = Hive.box('usuario');

  addUsuario(Map<String, dynamic> usuario) async {
    await _usuarioBox.add(usuario);
  }

  deleteUsuario() async {
    await _usuarioBox.clear();
  }

  readUsuario() {
    return _usuarioBox.values.first;
  }

  checkUsuario() {
    return _usuarioBox.isNotEmpty;
  }
}
