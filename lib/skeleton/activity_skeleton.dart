import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class ActivitySkeleton extends StatefulWidget {
  const ActivitySkeleton({super.key});

  @override
  State<ActivitySkeleton> createState() => _ActivitySkeletonState();
}

class _ActivitySkeletonState extends State<ActivitySkeleton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, value, __) {
          bool isDark = currentTheme.value == Brightness.dark;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: UiSize.iconCircleSmall,
                  height: UiSize.iconCircleSmall,
                  textColor: isDark ? UiColor.skeletonDark : UiColor.skeleton,
                  borderRadius: BorderRadius.circular(UiBorder.circle),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      width: MediaQuery.of(context).size.width - 82,
                      height: 16,
                      textColor:
                          isDark ? UiColor.skeletonDark : UiColor.skeleton,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                    const SizedBox(height: 4),
                    Skeleton(
                      width: 100,
                      height: 12,
                      textColor:
                          isDark ? UiColor.skeletonDark : UiColor.skeleton,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
