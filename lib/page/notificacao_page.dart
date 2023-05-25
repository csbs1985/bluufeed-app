import 'package:bluufeed_app/appbar/opcoes_appbar.dart';
import 'package:bluufeed_app/class/notificacao_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/notificacao_firestore.dart';
import 'package:bluufeed_app/modal/notificacao_modal.dart';
import 'package:bluufeed_app/skeleton/notificacao_item_skeleton.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/erro_resultado_widget.dart';
import 'package:bluufeed_app/widget/notificacao_item_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({
    super.key,
    required String idUsuario,
  }) : _idUsuario = idUsuario;

  final String _idUsuario;

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final NotificacaoFirestore _notificacaoFirestore = NotificacaoFirestore();

  int index = 1;

  @override
  void initState() {
    currentIsNotificacao.value = false;
    super.initState();
  }

  void _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const NotificacaoModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: OpcoesAppbar(callback: () => _abrirModal(context)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: TituloText(titulo: NOTIFICACAO),
            ),
            const SizedBox(height: 8),
            FirestoreListView(
              query: _notificacaoFirestore
                  .getAllNotificacaoUser(widget._idUsuario),
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
                return AnimationConfiguration.staggeredList(
                  position: index++,
                  duration: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: Column(
                        children: [
                          NotificacaoItemWidget(notificacao: snapshot.data()),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
