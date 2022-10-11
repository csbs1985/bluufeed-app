import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonCardWidget extends StatefulWidget {
  const ButtonCardWidget({Function? callback, required content})
      : _content = content,
        _callback = callback;

  final _content;
  final Function? _callback;

  @override
  _ButtonCardWidgetState createState() => _ButtonCardWidgetState();
}

class _ButtonCardWidgetState extends State<ButtonCardWidget> {
  String? _itemSelected;

  void _onPressed(item) {
    setState(() {
      _itemSelected = item.id;
      widget._callback!(item);
    });
  }

  bool _getSelected(String _id) {
    return _itemSelected == _id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget._content.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => _onPressed(widget._content[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getSelected(widget._content[index].id!)
                          ? UiColor.actived
                          : isDark
                              ? UiColor.buttonSecondaryDark
                              : UiColor.buttonSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(
                        UiPadding.medium,
                        UiPadding.small,
                        UiPadding.medium,
                        UiPadding.small,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Headline2(text: widget._content[index].title),
                          if (widget._content[index].text != '')
                            const SizedBox(height: UiPadding.small),
                          if (widget._content[index].text != '')
                            Headline2(text: widget._content[index].text)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
