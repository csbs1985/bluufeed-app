import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class CommentSkeleton extends StatelessWidget {
  const CommentSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, value, __) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(
              width: double.infinity,
              height: 24,
              textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
            const SizedBox(height: UiPadding.medium),
            Row(
              children: [
                Skeleton(
                  width: 100,
                  height: 12,
                  textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorder.rounded),
                ),
                const SizedBox(width: UiPadding.medium),
                Skeleton(
                  width: 100,
                  height: 12,
                  textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorder.rounded),
                ),
              ],
            ),
            const SizedBox(height: UiPadding.medium)
          ],
        );
      },
    );
  }
}
