import 'package:eight_app/class/categoria_class.dart';
import 'package:eight_app/class/historia_class.dart';
import 'package:eight_app/skeleton/historia_item_skeleton.dart';
import 'package:eight_app/text/fim_conteudo_text.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/widget/erro_resultado_widget.dart';
import 'package:eight_app/widget/historia_item_widget.dart';
import 'package:eight_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HistoriaListaWidget extends StatefulWidget {
  const HistoriaListaWidget({super.key});

  @override
  State<HistoriaListaWidget> createState() => _HistoriaListaWidgetState();
}

class _HistoriaListaWidgetState extends State<HistoriaListaWidget> {
  final HistoriaClass _historiaClass = HistoriaClass();

  int index = 1;

  @override
  void initState() {
    super.initState();
    _historiaClass.pegarHistoria();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

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
                  ErroResultadoWidget(altura: _altura),
              emptyBuilder: (context) => SemResultadoWidget(altura: _altura),
              itemBuilder: (
                BuildContext context,
                QueryDocumentSnapshot<dynamic> snapshot,
              ) {
                return AnimationConfiguration.staggeredList(
                  position: index++,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: HistoriaItemWidget(snapshot: snapshot.data()),
                    ),
                  ),
                );
              },
            ),
            const FimConteudoText(),
          ],
        );
      },
    );
  }
}
