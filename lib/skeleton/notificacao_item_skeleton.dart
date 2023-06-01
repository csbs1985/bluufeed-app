import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class NotificacaoItemSkeleton extends StatelessWidget {
  const NotificacaoItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isDark = tema == Brightness.dark;

        return Row(
          children: [
            Skeleton(
              width: 48,
              height: 48,
              textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
              borderRadius: BorderRadius.circular(UiBorda.circulo),
            ),
            const SizedBox(width: UiEspaco.large),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: MediaQuery.sizeOf(context).width - 48 - 16 - 16 - 16,
                  height: 24,
                  textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
                const SizedBox(height: UiEspaco.small),
                Skeleton(
                  width: 100,
                  height: 16,
                  textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
