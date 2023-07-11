import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_espaco.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class HistoriaItemSkeleton extends StatelessWidget {
  const HistoriaItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, value, __) {
        bool isDark = currentTema.value == Brightness.dark;

        return Container(
          padding: const EdgeInsets.fromLTRB(
            UiEspaco.large,
            UiEspaco.large,
            UiEspaco.large,
            UiEspaco.medium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: double.infinity,
                height: 20,
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
              const SizedBox(height: UiEspaco.medium),
              Skeleton(
                width: double.infinity,
                height: 32,
                textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(height: UiEspaco.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeleton(
                    width: 120,
                    height: 12,
                    textColor: isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor:
                            isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                        borderRadius:
                            BorderRadius.circular(UiBorda.arredondada),
                      ),
                      const SizedBox(width: UiEspaco.medium),
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor:
                            isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                        borderRadius:
                            BorderRadius.circular(UiBorda.arredondada),
                      ),
                      const SizedBox(width: UiEspaco.medium),
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor:
                            isDark ? UiCor.skeletonEscuro : UiCor.skeleton,
                        borderRadius:
                            BorderRadius.circular(UiBorda.arredondada),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
