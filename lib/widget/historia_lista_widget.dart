import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/skeleton/historia_item_skeleton.dart';
import 'package:bluufeed_app/text/fim_conteudo_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/historia_item_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class HistoriaListaWidget extends StatefulWidget {
  const HistoriaListaWidget({super.key});

  @override
  State<HistoriaListaWidget> createState() => _HistoriaListaWidgetState();
}

class _HistoriaListaWidgetState extends State<HistoriaListaWidget> {
  final HistoriaClass _historiaClass = HistoriaClass();

  @override
  void initState() {
    super.initState();

    _historiaClass.pegarHistoria();
  }

  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamalho.appbar * 4);

    return ValueListenableBuilder<CategoriaModel>(
      valueListenable: currentCategoria,
      builder: (BuildContext context, value, __) {
        return Column(
          children: [
            FirestoreListView(
              query: _historiaClass.pegarHistoria(),
              pageSize: 10,
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const HistoriaItemSkeleton(),
              errorBuilder: (context, error, _) =>
                  SemResultadoWidget(altura: _altura),
              itemBuilder: (BuildContext context,
                  QueryDocumentSnapshot<dynamic> snapshot) {
                return Column(
                  children: [
                    HistoriaItemWidget(snapshot: snapshot.data()),
                    const FimConteudoText()
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
