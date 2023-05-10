import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/input/padrao_input.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _biografiaController = TextEditingController();
  final UsuarioClass _usuarioClass = UsuarioClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  final bool _isFloatingButton = false;

  Map<String, dynamic>? _usuario;

  @override
  void initState() {
    super.initState();
    _iniciarForm();
  }

  _iniciarForm() async {
    QuerySnapshot doc = await _usuarioFirestore.getUsuarioId(widget._idUsuario);

    _nomeUsuarioController.text = doc.docs.first['nomeUsuario'];
    _biografiaController.text = doc.docs.first['biografia'];
  }

  _definirNomeUsuario(String value) {}

  _definirBiografia(String value) {}

  void _isFloatingActionButton() {
    setState(() {
      // _isFloatingButton =
      //     _nomeUsuarioFocus.hasFocus || _biografiaFocus.hasFocus ? true : false;
    });
  }

  _editarPerfil(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //TODO: verificar se criando conta e desabilitar
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const VoltarAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TituloText(title: EDITAR),
                const SizedBox(height: 24),
                const SubtituloText(subtitulo: USUARIO_NOME),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LegendaText(legenda: EDITAR_NOME),
                ),
                PadraoInput(
                  callback: (value) => _definirNomeUsuario(value),
                  controller: _nomeUsuarioController,
                  hintText: USUARIO_NOME,
                  minLines: 1,
                  maxLength: 20,
                ),
                const SizedBox(height: 8),
                const SubtituloText(subtitulo: BIOGRAFIA),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LegendaText(legenda: EDITAR_BIOGRAFIA),
                ),
                PadraoInput(
                  callback: (value) => _definirBiografia(value),
                  controller: _biografiaController,
                  hintText: BIOGRAFIA,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  maxLength: 300,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _isFloatingButton
            ? FloatingActionButton(
                backgroundColor: UiCor.botao,
                elevation: 0,
                onPressed: () => _editarPerfil(context),
                child: SvgPicture.asset(
                  UiSvg.confirmar,
                  color: UiCor.icone,
                ),
              )
            : null,
      ),
    );
  }
}
