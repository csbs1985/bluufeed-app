import 'package:bluufeed_app/appbar/voltar_appbar.dart';
import 'package:bluufeed_app/button/menu_button.dart';
import 'package:bluufeed_app/class/deletar_conta_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/modal/deleter_conta_modal.dart';
import 'package:bluufeed_app/modal/sair_modal.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DelatarContaPage extends StatefulWidget {
  const DelatarContaPage({super.key});

  @override
  State<DelatarContaPage> createState() => _DelatarContaPageState();
}

class _DelatarContaPageState extends State<DelatarContaPage> {
  void _selecionarDeletar(BuildContext context, int id) {
    if (id == DeletarContaEnum.DELETAR.value)
      _modalDeletar(context);
    else if (id == DeletarContaEnum.SAIR.value)
      _modalSair(context);
    else if (id == DeletarContaEnum.JUSTIFICAR.value)
      context.push(RouteEnum.JUSTIFICAR.value);
    else
      Navigator.of(context).pop();
  }

  void _modalSair(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const SairModal(),
    );
  }

  void _modalDeletar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const DeletarContaModal(),
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
              TituloText(titulo: 'Deletar conta'),
              const SizedBox(height: 24),
              const TextoText(texto: DELETAR_JUSTIFICAR),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listaDeletarConta.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => MenuButton(
                  subtitulo: listaDeletarConta[index].titulo,
                  resumo: listaDeletarConta[index].texto,
                  callback: () => _selecionarDeletar(
                    context,
                    listaDeletarConta[index].idDeletarConta,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
