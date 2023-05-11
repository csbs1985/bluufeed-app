import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/class/editar_perfil_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/input/padrao_input.dart';
import 'package:bluufeed_app/text/erro_text.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
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
  final EditarPerfilClass _editarPerfilClass = EditarPerfilClass();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ToastWidget _toastWidget = ToastWidget();
  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _biografiaController = TextEditingController();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  bool _isFloatingButton = false;

  final String _erro = "";

  QuerySnapshot? _usuario;

  @override
  void initState() {
    _iniciarForm();
    super.initState();
  }

  void _iniciarForm() async {
    _usuario = await _usuarioFirestore.getUsuarioId(widget._idUsuario);
    _biografiaController.text = _usuario!.docs.first['biografia'];
    _nomeUsuarioController.text =
        _usuario!.docs.first['nomeUsuario'].replaceAll(' ', '');
    _isFloatingActionButton();
  }

  void _isFloatingActionButton() {
    setState(() {
      _isFloatingButton = _nomeUsuarioController.text.isEmpty ? false : true;
    });
  }

  _editarPerfil(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('funciona');
    }
  }

  validarBiografia(String value) {
    if (value.length > 501) return EDITAR_ERRO_BIOGRAFIA;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //TODO: verificar se criando conta e desabilitar
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const VoltarAppbar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TituloText(title: EDITAR),
                  const SizedBox(height: 24),
                  if (_erro != "") ErroText(erro: _erro),
                  const SubtituloText(subtitulo: USUARIO_NOME),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LegendaText(legenda: EDITAR_NOME),
                  ),
                  PadraoInput(
                    callback: (value) => _isFloatingActionButton(),
                    controller: _nomeUsuarioController,
                    hintText: USUARIO_NOME,
                    onSaved: (value) => _nomeUsuarioController.text = value!,
                    minLines: 1,
                    maxLength: 20,
                    validator: _editarPerfilClass
                        .validarNomeUsuario(_nomeUsuarioController.text),
                  ),
                  const SizedBox(height: 8),
                  const SubtituloText(subtitulo: BIOGRAFIA),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: LegendaText(legenda: EDITAR_BIOGRAFIA),
                  ),
                  PadraoInput(
                    callback: (value) => _isFloatingActionButton(),
                    controller: _biografiaController,
                    hintText: BIOGRAFIA,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => _biografiaController.text = value!,
                    minLines: 1,
                    maxLines: null,
                    maxLength: 501,
                    validator: _editarPerfilClass
                        .validarBiografia(_biografiaController.text),
                  ),
                ],
              ),
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
