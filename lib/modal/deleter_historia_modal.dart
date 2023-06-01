import 'package:bluufeed_app/class/atividade_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/firestore/historia_firestore.dart';
import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:bluufeed_app/widget/toast_widget.dart';
import 'package:bluufeed_app/button/3d_button.dart';
import 'package:flutter/material.dart';

class DeletarHistoriaModal extends StatefulWidget {
  const DeletarHistoriaModal({
    super.key,
    required Map<String, dynamic> idHistoria,
  }) : _idHistoria = idHistoria;

  final Map<String, dynamic> _idHistoria;

  @override
  State<DeletarHistoriaModal> createState() => _UsuarioModalState();
}

class _UsuarioModalState extends State<DeletarHistoriaModal> {
  final AtividadeClass _atividadeClass = AtividadeClass();
  final HistoriaFirestore _historiaFirestore = HistoriaFirestore();
  final ToastWidget _toastWidget = ToastWidget();

  bool? isUsuario;

  Future<void> _deletarHistoria() async {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      await _historiaFirestore
          .deletarHistoriaId(widget._idHistoria['idHistoria'])
          .then((result) async => {
                await _atividadeClass.postAtividade(
                  tipoAtividade: AtividadeEnum.DELETE_HISTORY.value,
                  conteudo: widget._idHistoria['titulo'],
                  idConteudo: widget._idHistoria['idHistoria'],
                ),
                _toastWidget.toast(
                    context, ToastEnum.SUCESSO, HISTORIA_DELETAR_SUCESSO),
              });
    } catch (e) {
      _toastWidget.toast(context, ToastEnum.ERRO, HISTORIA_DELETAR_ERRO);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          decoration: BoxDecoration(
            color: isDark ? UiCor.mainEscuro : UiCor.main,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(UiBorda.arredondada),
              topRight: Radius.circular(UiBorda.arredondada),
            ),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: SubtituloResumoText(
                  subtitulo: HISTORIA_DELETAR,
                  resumo: HISTORIA_DELETAR_DESCRICAO,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const TextoText(texto: CANCELAR),
                  ),
                  const SizedBox(width: 16),
                  Button3d(
                    width: 150,
                    height: UiTamanho.botaoPrincipal,
                    style: Button3dStyle(
                      topColor: UiCor.botao,
                      backColor: UiCor.botaoBorda,
                      tappedZ: 0,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                      z: 4,
                    ),
                    child: const Text(
                      HISTORIA_DELETAR,
                      style: UiTexto.botao,
                    ),
                    onPressed: () => _deletarHistoria(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
