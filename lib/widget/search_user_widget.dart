import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/button/button_publish_widget.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/text/headline3.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/label_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({required List<AlgoliaObjectSnapshot>? snapshot})
      : _snapshot = snapshot;

  final List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  final HistoryService historyService = HistoryService();

  String _getNumbers(Map<String, dynamic> _item) {
    var qtyHistory = 'nenhuma história';
    var qtyComment = 'nenhuma comentário';

    if (_item['qtyHistory'] == 1) qtyHistory = '1 história';
    if (_item['qtyHistory'] > 1)
      qtyHistory = '${_item['qtyHistory'].toString()} histórias';

    if (_item['qtyComment'] == 1) qtyComment = '1 comentário';
    if (_item['qtyComment'] > 1)
      qtyComment = '${_item['qtyComment'].toString()} comentários';

    return qtyHistory + ' · ' + qtyComment;
  }

  void _getPerfil(String _idUser) {
    Navigator.pushNamed(
      context,
      PageEnum.PERFIL.value,
      arguments: _idUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget._snapshot == null
        ? _notResult()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            itemCount: widget._snapshot!.length,
            itemBuilder: (BuildContext context, int index) =>
                ValueListenableBuilder(
              valueListenable: currentTheme,
              builder: (BuildContext context, Brightness theme, _) {
                bool isDark = currentTheme.value == Brightness.dark;

                return Column(
                  children: [
                    TextButton(
                      onPressed: () => _getPerfil(
                        widget._snapshot![index].data['objectID'],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(UiPadding.small),
                        backgroundColor:
                            isDark ? UiColor.mainDark : UiColor.main,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(UiBorder.none),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: UiPadding.large,
                        ),
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
                                    Headline3(
                                      title:
                                          widget._snapshot![index].data['name'],
                                    ),
                                    LabelWidget(
                                      label: _getNumbers(
                                          widget._snapshot![index].data),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ButtonPublishWidget(
                              label: 'ver perfil',
                              callback: (value) => _getPerfil(
                                  widget._snapshot![index].data['objectID']),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const BorderWidget(),
                  ],
                );
              },
            ),
          );
  }

  Widget _notResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: UiSize.bottom,
            child: const Headline2(text: 'usuário não encontrado'),
          ),
        ],
      ),
    );
  }
}
