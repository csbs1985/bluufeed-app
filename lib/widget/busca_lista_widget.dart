import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/hive/busca_hive.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/separador_widget.dart';
import 'package:flutter/material.dart';

class BuscaListaWidget extends StatefulWidget {
  const BuscaListaWidget({super.key});

  @override
  State<BuscaListaWidget> createState() => _BuscaListaWidgetState();
}

class _BuscaListaWidgetState extends State<BuscaListaWidget> {
  final BuscaHive _buscaHive = BuscaHive();

  List<dynamic>? _listaBusca;

  @override
  void initState() {
    _listaBusca = _buscaHive.listaBusca();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _listaBusca = ['Item 1', 'Item 2', 'Item 3'];

    return Column(
      children: [
        const SeparadorWidget(),
        ListView.separated(
          shrinkWrap: true,
          itemCount: _listaBusca!.length,
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: InkWell(
                    child: TextoText(texto: _listaBusca![index]),
                    onTap: () => {},
                  ),
                ),
                IconeButton(
                  icone: UiSvg.fechar,
                  callback: () => _buscaHive.deleteBusca(_listaBusca![index]),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
