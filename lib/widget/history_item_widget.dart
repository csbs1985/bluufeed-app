import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/border_widget.dart';
import 'package:universe_history_app/widget/history_menu_widget.dart';
import 'package:universe_history_app/widget/info_widget.dart';
import 'package:universe_history_app/widget/separator_widget.dart';
import 'package:universe_history_app/widget/title_widget.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({
    required Map<String, dynamic> snapshot,
  }) : _snapshot = snapshot;

  final Map<String, dynamic> _snapshot;

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  final CategoriesClass categoriesClass = CategoriesClass();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            UiPadding.large,
            UiPadding.large,
            UiPadding.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget._snapshot['title'] != "")
                TitleWidget(title: widget._snapshot['title']),
              InfoWidget(resume: widget._snapshot),
              ExpandableText(
                widget._snapshot['text'],
                style: Theme.of(context).textTheme.headline2,
                expandText: 'ler tudo',
                collapseText: 'fechar',
                maxLines: 10,
                linkColor: UiColor.primary,
              ),
              const SizedBox(height: UiPadding.medium),
              Wrap(
                children: [
                  for (var item in widget._snapshot['categories'])
                    Padding(
                      padding: const EdgeInsets.only(right: UiPadding.small),
                      child: Text(
                        '#${categoriesClass.getCategoryLabel(item)}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: UiPadding.small),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: UiPadding.medium),
                child: BorderWidget(),
              ),
              HistoryMenuWidget(
                history: widget._snapshot,
                type: 'HOMEPAGE',
              )
            ],
          ),
        ),
        const SeparatorWidget(),
      ],
    );
  }
}
