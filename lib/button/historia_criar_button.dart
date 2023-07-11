import 'package:eight_app/class/historia_class.dart';
import 'package:eight_app/class/rotas_class.dart';
import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/modal/criar_historia_modal.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_tamanho.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HistoriaCriarButton extends StatelessWidget {
  final HistoriaClass _historiaClass = HistoriaClass();

  HistoriaCriarButton({super.key});

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
      height: UiTamanho.appbar,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.goNamed(RouteEnum.PERFIL.value,
                pathParameters: {'idUsuario': currentUsuario.value.idUsuario}),
            child: AvatarWidget(
              avatar: currentUsuario.value.avatarUsuario,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: currentTema,
              builder: (BuildContext context, Brightness tema, _) {
                bool isDark = tema == Brightness.dark;

                return GestureDetector(
                  onTap: () => _abrirModal(context),
                  child: Container(
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
