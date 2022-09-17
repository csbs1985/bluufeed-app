import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/modal/comment_modal.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/border_widget.dart';
import 'package:universe_history_app/widget/date_widget.dart';
import 'package:universe_history_app/widget/history_menu_widget.dart';
import 'package:universe_history_app/widget/label_widget.dart';
import 'package:universe_history_app/widget/separator_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/title_widget.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({
    required Map<String, dynamic> snapshot,
  }) : _item = snapshot;

  final Map<String, dynamic> _item;

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  final CategoriesClass categoriesClass = CategoriesClass();

  @override
  Widget build(BuildContext context) {
    var _route = ModalRoute.of(context)?.settings.name;

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
              if (widget._item['title'] != "")
                TitleWidget(title: widget._item['title']),
              DateWidget(
                type: CommentTypeEnum.HISTORY.value,
                item: widget._item,
              ),
              const SizedBox(height: UiPadding.medium),
              if (_route != PageEnum.HISTORY.value)
                ExpandableText(
                  widget._item['text'],
                  style: Theme.of(context).textTheme.headline2,
                  expandText: 'ler tudo',
                  collapseText: 'fechar',
                  maxLines: 10,
                  linkColor: UiColor.primary,
                ),
              if (_route == PageEnum.HISTORY.value)
                TextWidget(text: widget._item['text']),
              const SizedBox(height: UiPadding.medium),
              Wrap(
                children: [
                  for (var item in widget._item['categories'])
                    Padding(
                      padding: const EdgeInsets.only(right: UiPadding.small),
                      child: LabelWidget(
                        label: '#${categoriesClass.getCategoryLabel(item)}',
                      ),
                    ),
                ],
              ),
              const SizedBox(height: UiPadding.small),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: UiPadding.medium),
                child: BorderWidget(),
              ),
              HistoryMenuWidget(history: widget._item),
            ],
          ),
        ),
        if (_route != PageEnum.HISTORY.value) const SeparatorWidget(),
        if (_route == PageEnum.HISTORY.value)
          Container(
            padding: const EdgeInsets.fromLTRB(
              UiPadding.large,
              0,
              UiPadding.large,
              UiPadding.large,
            ),
            child: const BorderWidget(),
          ),
      ],
    );
  }
}
