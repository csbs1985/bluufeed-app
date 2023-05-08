import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class PerfilSkeleton extends StatelessWidget {
  const PerfilSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isDark = tema == Brightness.dark;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Skeleton(
                width: 100,
                height: 100,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.circulo),
              ),
              const SizedBox(height: 24),
              Skeleton(
                width: 200,
                height: 24,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(height: UiEspaco.medium),
              Skeleton(
                width: 300,
                height: 16,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(height: 24),
              Skeleton(
                width: 120,
                height: 40,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(height: UiEspaco.medium)
            ],
          ),
        );
      },
    );
  }
}
