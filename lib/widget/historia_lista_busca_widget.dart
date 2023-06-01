import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/class/busca_class.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/historia_item_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:flutter/material.dart';

class HistoriaListaBuscaWidget extends StatefulWidget {
  const HistoriaListaBuscaWidget({
    super.key,
    required List<AlgoliaObjectSnapshot>? snapshot,
  }) : _snapshot = snapshot;

  final List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  State<HistoriaListaBuscaWidget> createState() =>
      _HistoriaListaBuscaWidgetState();
}

class _HistoriaListaBuscaWidgetState extends State<HistoriaListaBuscaWidget> {
  final BuscaClass _buscaClass = BuscaClass();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return widget._snapshot!.isEmpty
        ? SemResultadoWidget(altura: _altura)
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            itemCount: widget._snapshot!.length,
            itemBuilder: (context, index) {
              return HistoriaItemWidget(
                snapshot: _buscaClass.algoliaToMap(widget._snapshot!),
              );
            },
          );
  }
}
