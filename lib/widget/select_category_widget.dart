import 'package:flutter/material.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/subtitle_resume_widget.dart';

class SelectCategoriesWidget extends StatefulWidget {
  final Function? _callback;
  final List<CategoryModel> _content;
  final List<String> _selected;
  final String _resume;
  final String _title;

  const SelectCategoriesWidget({
    required Function? callback,
    required List<CategoryModel> content,
    required String title,
    required String resume,
    required List<String> selected,
  })  : _callback = callback,
        _content = content,
        _resume = resume,
        _title = title,
        _selected = selected;

  @override
  _SelectCategoriesWidgetState createState() => _SelectCategoriesWidgetState();
}

class _SelectCategoriesWidgetState extends State<SelectCategoriesWidget> {
  List<String> listSelect = [];

  @override
  void initState() {
    if (widget._selected.isNotEmpty)
      for (var item in widget._selected) listSelect.add(item);

    super.initState();
  }

  void _setSelected(String id) {
    setState(() {
      listSelect.contains(id) ? listSelect.remove(id) : listSelect.add(id);
      if (widget._callback != null) widget._callback!(listSelect);
    });
  }

  bool _getSelected(String id) {
    return listSelect.contains(id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          // color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              UiPadding.large,
              UiPadding.medium,
              UiPadding.large,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleResumeWidget(
                  title: widget._title,
                  resume: widget._resume,
                ),
                const SizedBox(height: UiPadding.medium),
                Wrap(
                  children: [
                    for (var item in widget._content)
                      if (item.isShowInput! && !item.isDisabled!)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            UiPadding.medium,
                            UiPadding.medium,
                          ),
                          child: SizedBox(
                            height: 36,
                            child: TextButton(
                              onPressed: () => _setSelected(item.id!),
                              child: Text(
                                item.label!.toLowerCase(),
                                style: _getSelected(item.id!)
                                    ? Theme.of(context).textTheme.headline4
                                    : Theme.of(context).textTheme.headline2,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  _getSelected(item.id!)
                                      ? UiColor.tagActived
                                      : UiColor.tag,
                                ),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
