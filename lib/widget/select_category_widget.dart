import 'package:flutter/material.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/subtitle_resume_widget.dart';

class SelectCategoriesWidget extends StatefulWidget {
  final Function? _callback;

  final List<String> _selected;

  const SelectCategoriesWidget({
    required Function? callback,
    required List<String> selected,
  })  : _callback = callback,
        _selected = selected;

  @override
  _SelectCategoriesWidgetState createState() => _SelectCategoriesWidgetState();
}

class _SelectCategoriesWidgetState extends State<SelectCategoriesWidget> {
  List<CategoryModel> allCategories = CategoryModel.allCategories;
  List<String> listSelect = [];

  @override
  void initState() {
    if (widget._selected.isNotEmpty)
      for (var item in widget._selected) listSelect.add(item);

    super.initState();
  }

  bool _getSelected(String id) {
    return listSelect.contains(id) ? true : false;
  }

  void _setSelected(String id) {
    setState(() {
      listSelect.contains(id) ? listSelect.remove(id) : listSelect.add(id);
      if (widget._callback != null) widget._callback!(listSelect);
    });
  }

  getTagStyle() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SubtitleResumeWidget(
              title: 'Assunto',
              resume: 'Selecione ao menos uma categoria/tema.',
            ),
            const SizedBox(height: UiPadding.medium),
            Wrap(
              children: [
                for (var item in allCategories)
                  if (!item.isDisabled!)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        0,
                        UiPadding.medium,
                        UiPadding.medium,
                      ),
                      child: SizedBox(
                        height: UiSize.tag,
                        child: TextButton(
                          onPressed: () => _setSelected(item.id!),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              _getSelected(item.id!)
                                  ? UiColor.actived
                                  : isDark
                                      ? UiColor.inativedDark
                                      : UiColor.inatived,
                            ),
                          ),
                          child: Text(
                            item.label!.toLowerCase(),
                            style: _getSelected(item.id!)
                                ? UiText.button
                                : Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
