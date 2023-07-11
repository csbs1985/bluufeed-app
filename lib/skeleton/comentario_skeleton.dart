import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_espaco.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ComentarioSkeleton extends StatelessWidget {
  const ComentarioSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isDark = tema == Brightness.dark;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: double.infinity,
                height: 24,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(height: UiEspaco.medium),
              Row(
                children: [
                  Skeleton(
                    width: 100,
                    height: 12,
                    textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  const SizedBox(width: UiEspaco.medium),
                  Skeleton(
                    width: 100,
                    height: 12,
                    textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                ],
              ),
              const SizedBox(height: UiEspaco.medium)
            ],
          ),
        );
      },
    );
  }
}
