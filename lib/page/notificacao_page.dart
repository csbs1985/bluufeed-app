import 'package:bluufeed_app/appbar/opcoes_appbar.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/modal/notificacao_modal.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: OpcoesAppbar(callback: () => _abrirModal(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TituloText(title: NOTIFICACAO),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
