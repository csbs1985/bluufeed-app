import 'package:eight_app/class/categoria_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/text/subtitulo_reumo_text.dart';
import 'package:eight_app/theme/ui_botao.dart';
import 'package:eight_app/theme/ui_espaco.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/theme/ui_texto.dart';
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
  final CategoriaClass _categoriaClass = CategoriaClass();

  List<String> listaSelecionado = [];

  @override
  void initState() {
    if (widget._selecionado.isNotEmpty)
      for (var item in widget._selecionado)
        listaSelecionado.add(item.toString());

    super.initState();
  }

  void _selecionarCategoria(String id) {
    setState(() {
      listaSelecionado.contains(id)
          ? listaSelecionado.remove(id)
          : listaSelecionado.add(id);
      if (widget._callback != null) widget._callback!(listaSelecionado);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTema.value == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
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
                  for (var item in _categoriaClass.filtrarPorCategoria())
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 0, UiEspaco.medium, UiEspaco.medium),
                      child: SizedBox(
                        height: UiTamanho.tag,
                        child: TextButton(
                          onPressed: () =>
                              _selecionarCategoria(item.idCategoria),
                          style: _categoriaClass.isCategoriaSelecionada(
                                  listaSelecionado, item.idCategoria)
                              ? UiBotao.tagAtivo
                              : isDark
                                  ? UiBotao.tagEscuro
                                  : UiBotao.tag,
                          child: Text(
                            item.texto,
                            style: _categoriaClass.isCategoriaSelecionada(
                                    listaSelecionado, item.idCategoria)
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
          ),
        );
      },
    );
  }
}
