import 'package:flutter/material.dart';
import 'package:bluuffed_app/model/category_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_button.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  List<CategoryModel> allCategories = CategoryModel.allCategories;

  @override
  Widget build(BuildContext context) {
    bool canShow(CategoryModel item) {
      if (item.isDisabled!) return false;
      if (item.isLogin! && currentUser.value.isNotEmpty) return true;
      return true;
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
          height: UiSize.menuHeight,
          child: ListView.builder(
            itemCount: CategoryModel.allCategories.length,
            padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ValueListenableBuilder(
                valueListenable: currentUser,
                builder: (BuildContext context, value, _) {
                  return Row(
                    children: [
                      if (canShow(allCategories[index]))
                        Padding(
                          padding:
                              const EdgeInsets.only(right: UiPadding.medium),
                          child: TextButton(
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
                        ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
