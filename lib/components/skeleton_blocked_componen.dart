import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonBlockedComponent extends StatelessWidget {
  const SkeletonBlockedComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(
                      width: (MediaQuery.of(context).size.width - 150),
                      height: 20,
                      textColor: UiColor.comp_3,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                    const SizedBox(height: 10),
                    Skeleton(
                      width: 200,
                      height: 16,
                      textColor: UiColor.comp_3,
                      borderRadius: BorderRadius.circular(UiBorder.rounded),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Skeleton(
                    width: 100,
                    height: 46,
                    textColor: UiColor.comp_3,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
