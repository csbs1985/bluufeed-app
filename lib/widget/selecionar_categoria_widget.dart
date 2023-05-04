import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/theme/ui_botao.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';

class SelecionatCategoriaWidget extends StatefulWidget {
  const SelecionatCategoriaWidget({
    super.key,
    required Function? callback,
    required List<Object> selecionado,
  })  : _callback = callback,
        _selecionado = selecionado;

  final List<Object> _selecionado;
  final Function? _callback;

  @override
  _SelecionatCategoriaWidgetState createState() =>
      _SelecionatCategoriaWidgetState();
}

class _SelecionatCategoriaWidgetState extends State<SelecionatCategoriaWidget> {
  List<String> listSelect = [];

  @override
  void initState() {
    if (widget._selecionado.isNotEmpty)
      for (var item in widget._selecionado) listSelect.add(item.toString());

    super.initState();
  }

  bool _isCategoriaSelecionada(String id) {
    return listSelect.contains(id) ? true : false;
  }

  void _selecionarCategoria(String id) {
    setState(() {
      listSelect.contains(id) ? listSelect.remove(id) : listSelect.add(id);
      if (widget._callback != null) widget._callback!(listSelect);
    });
  }

  getTagStyle() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTema.value == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SubtituloResumoText(
              subtitulo: ASSUNTO,
              resumo: ASSUNTO_SELECIONE,
            ),
            const SizedBox(height: UiEspaco.medium),
            Wrap(
              children: [
                for (var item in listaCategoria)
                  if (!item.isDesabilitada!)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        0,
                        UiEspaco.medium,
                        UiEspaco.medium,
                      ),
                      child: SizedBox(
                        height: UiTamanho.tag,
                        child: TextButton(
                          onPressed: () =>
                              _selecionarCategoria(item.idCategoria!),
                          style: _isCategoriaSelecionada(item.idCategoria!)
                              ? UiBotao.tagAtivo
                              : isDark
                                  ? UiBotao.tagEscuro
                                  : UiBotao.tag,
                          child: Text(
                            item.texto!.toLowerCase(),
                            style: _isCategoriaSelecionada(item.idCategoria!)
                                ? UiTexto.tagAtiva
                                : isDark
                                    ? UiTexto.tagEscuro
                                    : UiTexto.tag,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
