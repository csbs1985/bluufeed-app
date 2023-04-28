import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/text/subtitulo_reumo_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
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
      for (var item in widget._selecionado) {
        listSelect.add(item.toString());
      }

    super.initState();
  }

  bool _getSelected(String id) {
    return listSelect.contains(id) ? true : false;
  }

  void _setSelected(String id) {
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
              subtitulo: 'Assunto',
              resumo: 'Selecione ao menos uma categoria/tema.',
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
                        height: UiTamalho.tag,
                        child: TextButton(
                          onPressed: () => _setSelected(item.idCategoria!),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              _getSelected(item.idCategoria!)
                                  ? UiCor.ativo
                                  : isDark
                                      ? UiCor.botaoSegundoEscuro
                                      : UiCor.botaoSegundo,
                            ),
                          ),
                          child: Text(
                            item.texto!.toLowerCase(),
                            style: _getSelected(item.idCategoria!)
                                ? Theme.of(context).textTheme.displayMedium
                                : Theme.of(context).textTheme.displayMedium,
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
