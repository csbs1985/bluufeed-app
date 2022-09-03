import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';

class AppBarHomeWidget extends StatefulWidget {
  const AppBarHomeWidget({super.key});

  @override
  State<AppBarHomeWidget> createState() => _AppBarHomeWidgetState();
}

class _AppBarHomeWidgetState extends State<AppBarHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: UiSize.bottomNavigation,
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
      child: SvgPicture.asset(UiIcon.identity),
    );
  }
}
