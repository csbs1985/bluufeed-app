import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_size.dart';

ValueNotifier<String> currentPage = ValueNotifier('home');

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  void changeIcon(String page) {
    currentPage.value = page;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (BuildContext context, String currentPage, _) {
        return SizedBox(
          height: UiSize.bottomNavigation,
          width: double.maxFinite,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  currentPage == 'home' ? UiIcon.logoActived : UiIcon.logo,
                ),
                onPressed: () {
                  changeIcon('home');
                },
              ),
              IconButton(
                icon: SvgPicture.asset(UiIcon.create),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  currentPage == 'notification'
                      ? UiIcon.notificationActived
                      : UiIcon.notification,
                ),
                onPressed: () {
                  changeIcon('notification');
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  currentPage == 'settings'
                      ? UiIcon.optionsActived
                      : UiIcon.options,
                ),
                onPressed: () {
                  changeIcon('settings');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
