import 'package:bluuffed_app/button/button_publish_widget.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserItemWidget extends StatefulWidget {
  const UserItemWidget({required List<dynamic> content}) : _content = content;

  final List<dynamic> _content;

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  final HistoryService historyService = HistoryService();

  void _getPerfil(String _idUser) {
    Navigator.pushNamed(context, PageEnum.PERFIL.value, arguments: _idUser);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      reverse: true,
      itemCount: widget._content.length,
      itemBuilder: (BuildContext context, int index) {
        return ValueListenableBuilder(
          valueListenable: currentTheme,
          builder: (BuildContext context, Brightness theme, _) {
            bool isDark = currentTheme.value == Brightness.dark;

            return Column(
              children: [
                TextButton(
                  onPressed: () => _getPerfil(
                    widget._content[index]['objectID'] ??
                        widget._content[index]['id'],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(UiPadding.small),
                    backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(UiBorder.none),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: UiPadding.large),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(UiIcon.perfilActived),
                            const SizedBox(width: UiPadding.large),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Headline2(text: widget._content[index]['name']),
                              ],
                            ),
                          ],
                        ),
                        ButtonPublishWidget(
                          label: 'ver perfil',
                          callback: (value) =>
                              _getPerfil(widget._content[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
                const BorderWidget(),
              ],
            );
          },
        );
      },
    );
  }
}
