import 'package:bluufeed_app/appbar/opcoes_appbar.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';
import 'package:bluufeed_app/modal/historia_modal.dart';
import 'package:bluufeed_app/skeleton/historia_item_skeleton.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/widget/historia_info_widget.dart';
import 'package:bluufeed_app/widget/historia_interacao_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:bluufeed_app/widget/usuario_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoriaPage extends StatefulWidget {
  const HistoriaPage({
    super.key,
    required String idHistoria,
  }) : _idHistoria = idHistoria;

  final String _idHistoria;

  @override
  State<HistoriaPage> createState() => _HistoriaPageState();
}

class _HistoriaPageState extends State<HistoriaPage> {
  final CategoriaClass _categoriesClass = CategoriaClass();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();

  Map<String, dynamic> _historia = {};

  void _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => HistoriaModal(historia: _historia),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: OpcoesAppbar(callback: () => _abrirModal(context)),
      body: StreamBuilder<QuerySnapshot>(
        stream: _historiaFirestore.snapshotsHistoria(widget._idHistoria),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const SemResultadoWidget(altura: 300);
            case ConnectionState.waiting:
              return const HistoriaItemSkeleton();
            case ConnectionState.done:
            default:
              _historia = HistoriaModel.toMap(snapshot.data!.docs[0]);

              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(UiEspaco.large),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TituloText(titulo: _historia['titulo']),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextoText(texto: _historia['texto']),
                            ),
                            Wrap(
                              children: [
                                for (var item in _historia['categorias'])
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 4, 0),
                                    child: TagText(
                                      tag: _categoriesClass
                                          .pegarTextoCategoria(item),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: HistoriaInfoWidget(
                          item: _historia,
                          isAvatar: false,
                        ),
                      ),
                      HistoriaInteracaoWidget(historia: _historia),
                      UsuarioItemWidget(idUsuario: _historia['idUsuario']),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
