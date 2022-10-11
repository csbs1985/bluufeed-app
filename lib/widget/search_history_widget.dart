import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/search_date_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/title_widget.dart';
import 'package:flutter/material.dart';

class SearchHistoryWidget extends StatefulWidget {
  const SearchHistoryWidget({required List<AlgoliaObjectSnapshot>? snapshot})
      : _snapshot = snapshot;

  final List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  State<SearchHistoryWidget> createState() => _SearchHistoryWidgetState();
}

class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: UiPadding.large,
                          vertical: UiPadding.medium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget(
                                title: widget._snapshot![index].data['title']),
                            SearchDateWidget(
                                item: widget._snapshot![index].data),
                            const SizedBox(height: UiPadding.medium),
                            Headline2(
                                text: widget._snapshot![index].data['text']),
                            const SizedBox(height: UiPadding.large),
                          ],
                        ),
                      ),
                      const BorderWidget(),
                    ],
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
            child: const Headline2(
              text: 'não encontramos histórias para sua pesquisa',
            ),
          ),
        ],
      ),
    );
  }
}
