import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //TODO: verificar se criando conta e desabilitar
      onWillPop: () async => false,
      child: const Scaffold(
        appBar: VoltarAppbar(),
        body: SingleChildScrollView(),
      ),
    );
  }
}
