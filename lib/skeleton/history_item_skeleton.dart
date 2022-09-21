import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class HistoryItemSkeleton extends StatelessWidget {
  HistoryItemSkeleton({Key? key}) : super(key: key);

  Color color = UiColor.border;

  void _getColor() {
    bool isDark = currentTheme.value == Brightness.dark;
    color = isDark ? UiColor.skeletonDark : UiColor.skeleton;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, value, __) {
        _getColor();
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            UiPadding.medium,
            UiPadding.large,
            UiPadding.medium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: double.infinity,
                height: 20,
                textColor: color,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              const SizedBox(height: UiPadding.medium),
              Row(
                children: [
                  Skeleton(
                    width: 100,
                    height: 12,
                    textColor: color,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  const SizedBox(width: UiPadding.medium),
                  Skeleton(
                    width: 100,
                    height: 12,
                    textColor: color,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                ],
              ),
              const SizedBox(height: UiPadding.medium),
              Skeleton(
                width: double.infinity,
                height: 32,
                textColor: color,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              const SizedBox(height: UiPadding.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeleton(
                    width: 120,
                    height: 12,
                    textColor: color,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor: color,
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                      ),
                      const SizedBox(width: UiPadding.medium),
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor: color,
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                      ),
                      const SizedBox(width: UiPadding.medium),
                      Skeleton(
                        width: 40,
                        height: 12,
                        textColor: color,
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
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
