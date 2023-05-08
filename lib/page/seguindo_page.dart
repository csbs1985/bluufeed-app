import 'package:bluufeed_app/appbar/simples_appbar.dart';
import 'package:flutter/material.dart';

class SeguindoPage extends StatefulWidget {
  const SeguindoPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<SeguindoPage> createState() => _SeguindoPageState();
}

class _SeguindoPageState extends State<SeguindoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplesAppbar(callback: () => {}),
    );
  }
}
