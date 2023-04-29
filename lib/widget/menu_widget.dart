import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/theme/ui_botao.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    bool podeMostrar(CategoriaModel item) {
      return item.isDesabilitada! ? false : true;
    }

    bool _itemSelecionado(CategoriaModel item) {
      return currentCategoria.value.idCategoria == item.idCategoria
          ? true
          : false;
    }

    void _selecionarItem(CategoriaModel item) {
      setState(() => currentCategoria.value = item);
    }

    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          color: isDark ? UiCor.bordaEscura : UiCor.borda,
          height: UiTamalho.appbar,
          child: ListView.builder(
            itemCount: listaCategoria.length,
            padding: const EdgeInsets.only(left: UiEspaco.large),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ValueListenableBuilder(
                valueListenable: currentUsuario,
                builder: (BuildContext context, value, _) {
                  return Row(
                    children: [
                      if (podeMostrar(listaCategoria[index]))
                        Padding(
                          padding:
                              const EdgeInsets.only(right: UiEspaco.medium),
                          child: TextButton(
                            onPressed: () =>
                                _selecionarItem(listaCategoria[index]),
                            style: _itemSelecionado(listaCategoria[index])
                                ? UiBotao.buttonActived
                                : isDark
                                    ? UiBotao.buttonDark
                                    : UiBotao.button,
                            child: Text(
                              listaCategoria[index].texto!.toLowerCase(),
                              style: _itemSelecionado(listaCategoria[index])
                                  ? Theme.of(context).textTheme.displayMedium
                                  : Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}