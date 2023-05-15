import 'package:bluufeed_app/appbar/opcoes_appbar.dart';
import 'package:bluufeed_app/button/seguindo_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/class/data_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';
import 'package:bluufeed_app/modal/usuario_modal.dart';
import 'package:bluufeed_app/skeleton/historia_item_skeleton.dart';
import 'package:bluufeed_app/text/fim_conteudo_text.dart';
import 'package:bluufeed_app/text/subtitulo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/erro_resultado_widget.dart';
import 'package:bluufeed_app/widget/historia_item_widget.dart';
import 'package:bluufeed_app/widget/separador_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class PerfilItemWidget extends StatefulWidget {
  const PerfilItemWidget({
    super.key,
    required Map<String, dynamic> usuario,
  }) : _usuario = usuario;

  final Map<String, dynamic> _usuario;

  @override
  State<PerfilItemWidget> createState() => _PerfilItemWidgetState();
}

class _PerfilItemWidgetState extends State<PerfilItemWidget> {
  final DataClass _dataClass = DataClass();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UsuarioClass _usuarioClass = UsuarioClass();

  static const _marginPequena = SizedBox(height: 16);

  bool? isUsuario;

  Map<String, dynamic>? _seguindo;

  @override
  void initState() {
    // _usuarioClass.getUsuarioId(widget._usuario);
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

  void _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => UsuarioModal(usuario: widget._usuario),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return Scaffold(
      key: scaffoldKey,
      appBar: OpcoesAppbar(callback: () => _abrirModal(context)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AvatarWidget(
                        size: 60,
                        avatar: widget._usuario['avatarusuario'],
                      ),
                      _marginPequena,
                      if (isUsuario!)
                        TituloText(
                          titulo: widget._usuario['nomeUsuario'],
                        ),
                      TextoText(
                        texto: widget._usuario['email'],
                      ),
                      if (!isUsuario!) const SizedBox(height: 24),
                      if (!isUsuario!)
                        SeguirButton(
                          tamanhoPadrao: false,
                          idUsuario: widget._usuario['idUsuario'],
                        ),
                    ],
                  ),
                ),
                if (isUsuario!) const SeparadorWidget(),
                if (isUsuario!) SeguindoButton(usuario: widget._usuario),
                const SeparadorWidget(),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtituloText(subtitulo: ENTROU),
                      const SizedBox(height: 16),
                      TextoText(
                          texto: _dataClass
                              .dataInteira(widget._usuario['dataRegistro']))
                    ],
                  ),
                ),
                const SeparadorWidget(),
                if (widget._usuario['biografia'] != '')
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SubtituloText(subtitulo: BIOGRAFIA),
                        const SizedBox(height: 16),
                        TextoText(texto: widget._usuario['biografia']),
                      ],
                    ),
                  ),
                const SeparadorWidget(),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: SubtituloText(subtitulo: PUBLICACOES),
                    ),
                    FirestoreListView(
                      query: _historiaFirestore.historias
                          .orderBy('dataRegistro')
                          .where('idUsuario',
                              isEqualTo: widget._usuario['idUsuario']),
                      pageSize: 10,
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      loadingBuilder: (context) => const HistoriaItemSkeleton(),
                      errorBuilder: (context, error, _) =>
                          ErroResultadoWidget(altura: _altura),
                      itemBuilder: (BuildContext context,
                          QueryDocumentSnapshot<dynamic> snapshot) {
                        return HistoriaItemWidget(snapshot: snapshot.data());
                      },
                    ),
                    const FimConteudoText(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
