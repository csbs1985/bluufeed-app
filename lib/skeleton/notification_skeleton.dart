import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class NotificationSkeleton extends StatelessWidget {
  const NotificationSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, value, __) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            UiPadding.medium,
            UiPadding.large,
            UiPadding.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      width: double.infinity,
                      height: 16,
                      textColor:
                          isDark ? UiColor.skeletonDark : UiColor.skeleton,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                    const SizedBox(height: UiPadding.medium),
                    Skeleton(
                      width: (MediaQuery.of(context).size.width * .8),
                      height: 16,
                      textColor:
                          isDark ? UiColor.skeletonDark : UiColor.skeleton,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
