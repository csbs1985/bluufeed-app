import 'package:bluuffed_app/model/search_model.dart';
import 'package:bluuffed_app/theme/ui_button.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class SearchMenuWidget extends StatefulWidget {
  SearchMenuWidget({
    required Function callback,
    required String init,
  })  : _callback = callback,
        _init = init;

  final Function _callback;
  late String _init;

  @override
  State<SearchMenuWidget> createState() => _SearchMenuWidgetState();
}

class _SearchMenuWidgetState extends State<SearchMenuWidget> {
  final List<Map<String, String>> _listMenu = [
    {'key': SearchMenuEnum.HISTORY.value, 'value': 'histórias'},
    {'key': SearchMenuEnum.USER.value, 'value': 'usuários'}
  ];

  void _selectItem(String _key) {
    setState(() {
      widget._callback(_key);
      widget._init = _key;
    });
  }

  bool _getSelected(String _key) {
    return widget._init == _key ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          color: isDark ? UiColor.borderDark : UiColor.border,
          height: UiSize.menuHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _listMenu.length,
            padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: UiPadding.medium),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 22,
                      child: TextButton(
                        onPressed: () => _selectItem(_listMenu[index]['key']!),
                        style: _getSelected(_listMenu[index]['key']!)
                            ? UiButton.buttonActived
                            : isDark
                                ? UiButton.buttonDark
                                : UiButton.button,
                        child: Text(
                          _listMenu[index]['value']!,
                          style: _getSelected(_listMenu[index]['key']!)
                              ? UiText.button
                              : Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
