import 'package:bluufeed_app/appbar/opcoes_appbar.dart';
import 'package:bluufeed_app/button/seguindo_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/class/data_class.dart';
import 'package:bluufeed_app/class/seguindo_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/firestore/historia_firebase.dart';
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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  final SeguindoClass _seguindoClass = SeguindoClass();

  static const _marginPequena = SizedBox(height: 16);

  void _abrirModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: UiCor.overlay,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarWidget(
                        size: 60,
                        avatar: widget._usuario['avatarusuario'],
                      ),
                      _marginPequena,
                      TituloText(
                        title: widget._usuario['nomeUsuario'],
                      ),
                      TextoText(
                        texto: widget._usuario['email'],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SeguirButton(
                            tamanhoPadrao: false,
                            usuario: _seguindoClass.toSeguindo(widget._usuario),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SeparadorWidget(),
                SeguindoButton(usuario: widget._usuario),
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
                          .orderBy('dataCriacao')
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
