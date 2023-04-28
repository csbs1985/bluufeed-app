import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/firestore/historia_firebase.dart';
import 'package:bluufeed_app/widget/historia_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class HistoriaListaWidget extends StatefulWidget {
  const HistoriaListaWidget({super.key});

  @override
  State<HistoriaListaWidget> createState() => _HistoriaListaWidgetState();
}

class _HistoriaListaWidgetState extends State<HistoriaListaWidget> {
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();

  @override
  void initState() {
    super.initState();

    _getContent();
  }

  _getContent() {
    String _category = currentCategoria.value.idCategoria!;

    if (_category != CategoriaEnum.ALL.value &&
        _category != CategoriaEnum.MY.value &&
        _category != CategoriaEnum.SAVE.value) {
      return _historiaFirestore.historias
          .orderBy('date')
          .where('categories', arrayContainsAny: [_category]);
    }

    if (_category == CategoriaEnum.MY.value) {
      return _historiaFirestore.historias
          .orderBy('date')
          .where('userId', isEqualTo: currentUsuario.value.idUsuario);
    }

    if (_category == CategoriaEnum.SAVE.value) {
      return _historiaFirestore.historias.orderBy('date').where('bookmarks',
          arrayContainsAny: [currentUsuario.value.idUsuario]);
    }

    return _historiaFirestore.historias.orderBy('date');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoriaModel>(
      valueListenable: currentCategoria,
      builder: (BuildContext context, value, __) {
        return Column(
          children: [
            FirestoreListView(
              query: _getContent(),
              pageSize: 10,
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              // loadingBuilder: (context) => const HistoryItemSkeleton(),
              // errorBuilder: (context, error, _) => const HistoryItemSkeleton(),
              itemBuilder: (BuildContext context,
                  QueryDocumentSnapshot<dynamic> snapshot) {
                return HistoriaItemWidget(snapshot: snapshot.data());
              },
            ),
            // const NoResultWidget(text: 'Isso é tudo por enquanto.'),
          ],
        );
      },
    );
  }
}
