import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/modal/criar_historia_modal.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CriarBotao extends StatelessWidget {
  final HistoriaClass _historiaClass = HistoriaClass();

  CriarBotao({super.key});

  void _abrirModal(BuildContext context) {
    _historiaClass.limparCurrentHistoria();

    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) => const CriarHistoriaModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: UiTamalho.appbar,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const AvatarWidget(size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => _abrirModal(context),
              child: ValueListenableBuilder(
                  valueListenable: currentTema,
                  builder: (BuildContext context, Brightness theme, _) {
                    bool isDark = theme == Brightness.dark;

                    return Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? UiCor.bordaEscura : UiCor.borda,
                        borderRadius: BorderRadius.circular(UiBorda.circulo),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          CRIAR_BOTAO,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
