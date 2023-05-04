import 'package:bluufeed_app/class/busca_class.dart';
import 'package:bluufeed_app/theme/ui_botao.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/theme/ui_texto.dart';
import 'package:flutter/material.dart';

class BuscaMenu extends StatefulWidget {
  const BuscaMenu({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<BuscaMenu> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<BuscaMenu> {
  String _busca = BuscaEnum.HISTORIA.value;

  bool _itemSelecionado(BuscaModel item) {
    return _busca == item.texto ? true : false;
  }

  void _selecionarItem(BuscaModel item) {
    setState(() => _busca = item.texto);
    widget._callback(item.texto);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          color: isDark ? UiCor.bordaEscura : UiCor.borda,
          height: UiTamanho.appbar,
          child: ListView.builder(
            itemCount: listaBusca.length,
            padding: const EdgeInsets.only(left: UiEspaco.large),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: UiEspaco.medium),
                    child: TextButton(
                      onPressed: () => _selecionarItem(listaBusca[index]),
                      style: _itemSelecionado(listaBusca[index])
                          ? UiBotao.tagAtivo
                          : isDark
                              ? UiBotao.tagEscuro
                              : UiBotao.tag,
                      child: Text(
                        listaBusca[index].texto.toLowerCase(),
                        style: _itemSelecionado(listaBusca[index])
                            ? UiTexto.tagAtiva
                            : isDark
                                ? UiTexto.tagEscuro
                                : UiTexto.tag,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
