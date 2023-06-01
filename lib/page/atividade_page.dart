import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/atividade_firestore.dart';
import 'package:bluufeed_app/skeleton/notificacao_item_skeleton.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/atividade_item_widget.dart';
import 'package:bluufeed_app/widget/erro_resultado_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class AtividadePage extends StatefulWidget {
  const AtividadePage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  final AtividadeFirestore _atividadeFirestore = AtividadeFirestore();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: TituloText(titulo: ATIVIDADE),
            ),
            const SizedBox(height: 8),
            FirestoreListView(
              query:
                  _atividadeFirestore.getAllAtividadeUsuario(widget._idUsuario),
              pageSize: 25,
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const NotificacaoItemSkeleton(),
              errorBuilder: (context, error, _) =>
                  ErroResultadoWidget(altura: _altura),
              emptyBuilder: (context) => SemResultadoWidget(altura: _altura),
              itemBuilder: (
                BuildContext context,
                QueryDocumentSnapshot<dynamic> snapshot,
              ) {
                return Column(
                  children: [
                    AtividadeItemWidget(atividade: snapshot.data()),
                    const SizedBox(height: 4),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
