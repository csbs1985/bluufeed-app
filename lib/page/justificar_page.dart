import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/button/menu_button.dart';
import 'package:bluufeed_app/class/justificar_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/modal/deleter_conta_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class JustificarPage extends StatefulWidget {
  const JustificarPage({super.key});

  @override
  State<JustificarPage> createState() => _DelatarContaPageState();
}

class _DelatarContaPageState extends State<JustificarPage> {
  void _abrirModal(BuildContext context, int _idJustificar) {
    setState(() {});
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => DeletarContaModal(idJustificar: _idJustificar),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TituloText(titulo: JUSTIFICAR),
              const SizedBox(height: 24),
              const TextoText(texto: JUSTIFICAR_DESCRICAO),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listaJustificar.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => MenuButton(
                  subtitulo: listaJustificar[index].titulo,
                  resumo: listaJustificar[index].texto,
                  callback: () =>
                      _abrirModal(context, listaJustificar[index].idJustificar),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
