import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class UserItemSkeleton extends StatefulWidget {
  const UserItemSkeleton({super.key});

  @override
  State<UserItemSkeleton> createState() => _UserItemSkeletonState();
}

class _UserItemSkeletonState extends State<UserItemSkeleton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, value, __) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          padding: const EdgeInsets.all(UiPadding.large),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Skeleton(
                    width: 32,
                    height: 32,
                    textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorder.circle),
                  ),
                  const SizedBox(width: UiPadding.large),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(
                        width: 100,
                        height: 20,
                        textColor:
                            isDark ? UiColor.skeletonDark : UiColor.skeleton,
                        borderRadius: BorderRadius.circular(UiBorder.circle),
                      ),
                      const SizedBox(height: UiPadding.small),
                      Skeleton(
                        width: 160,
                        height: 16,
                        textColor:
                            isDark ? UiColor.skeletonDark : UiColor.skeleton,
                        borderRadius: BorderRadius.circular(UiBorder.circle),
                      ),
                    ],
                  ),
                ],
              ),
              Skeleton(
                width: 70,
                height: 42,
                textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
                borderRadius: BorderRadius.circular(UiBorder.circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
