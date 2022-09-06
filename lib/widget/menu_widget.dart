import 'package:flutter/material.dart';
import 'package:universe_history_app/model/category_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  List<CategoryModel> allCategories = CategoryModel.allCategories;

  @override
  Widget build(BuildContext context) {
    bool canShow(String? item) {
      return (item == CategoriesEnum.MY.name ||
                  item == CategoriesEnum.SAVE.name) &&
              currentUser.value.isEmpty
          ? false
          : true;
    }

    bool _getSelected(CategoryModel item) {
      return currentCategory.value.id == item.id ? true : false;
    }

    void _select(CategoryModel item) {
      setState(() => currentCategory.value = item);
    }

    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          color: isDark ? UiColor.borderDark : UiColor.border,
          height: 68,
          child: ListView.builder(
            itemCount: CategoryModel.allCategories.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return canShow(allCategories[index].id)
                  ? Row(
                      children: [
                        TextButton(
                          onPressed: () => _select(allCategories[index]),
                          style: _getSelected(allCategories[index])
                              ? UiButton.buttonActived
                              : isDark
                                  ? UiButton.buttonDark
                                  : UiButton.button,
                          child: Text(
                            allCategories[index].label!.toLowerCase(),
                            style: _getSelected(allCategories[index])
                                ? UiText.button
                                : Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(width: UiPadding.medium)
                      ],
                    )
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }
}
