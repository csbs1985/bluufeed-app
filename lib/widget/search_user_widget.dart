import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/button/button_publish_widget.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({required List<AlgoliaObjectSnapshot>? snapshot})
      : _snapshot = snapshot;

  final List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  final HistoryService historyService = HistoryService();

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

                return TextButton(
                  onPressed: () => historyService.getHistoryPage(
                      widget._snapshot![index].data['objectID']),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
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
                        TextWidget(text: widget._snapshot![index].data['name']),
                        ButtonPublishWidget(
                          label: 'ver perfil',
                          callback: (value) => Navigator.pushNamed(
                            context,
                            PageEnum.PERFIL.value,
                            arguments:
                                widget._snapshot![index].data['objectID'],
                          ),
                          // _formatAlgolia(context, widget._snapshot![index]),
                        ),
                      ],
                    ),
                  ),
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
            child: const TextWidget(text: 'usuário não encontrado'),
          ),
        ],
      ),
    );
  }
}
