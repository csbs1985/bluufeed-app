import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class SeguindoSkeleton extends StatelessWidget {
  const SeguindoSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isDark = tema == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeleton(
                width: 48,
                height: 48,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.circulo),
              ),
              const SizedBox(width: UiEspaco.large),
              Expanded(
                child: Skeleton(
                  width: 200,
                  height: 24,
                  textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
              ),
              const SizedBox(width: UiEspaco.medium),
              Skeleton(
                width: 100,
                height: 40,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
            ],
          ),
        );
      },
    );
  }
}
