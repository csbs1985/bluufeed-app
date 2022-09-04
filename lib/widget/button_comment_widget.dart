import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/border_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class ButtonCommentWidget extends StatefulWidget {
  const ButtonCommentWidget({Key? key}) : super(key: key);

  @override
  State<ButtonCommentWidget> createState() => _ButtonCommentWidgetState();
}

class _ButtonCommentWidgetState extends State<ButtonCommentWidget> {
  void _showModal(BuildContext context, String historyId, bool openKeyboard) {
    // showCupertinoModalBottomSheet(
    //     expand: true,
    //     context: context,
    //     barrierColor: Colors.black87,
    //     duration: const Duration(milliseconds: 300),
    //     builder: (context) => const InputCommmentModal());
  }

  bool _isShow() {
    // return currentHistory.value.first.isComment && currentUser.value.isNotEmpty
    //     ? false
    //     : true;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return !_isShow()
        ? const SizedBox()
        : ValueListenableBuilder(
            valueListenable: currentTheme,
            builder: (BuildContext context, Brightness theme, _) {
              bool isDark = currentTheme.value == Brightness.dark;

              return Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const BorderWidget(),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: isDark ? UiColor.mainDark : UiColor.main,
                        width: double.infinity,
                        height: UiSize.bottomNavigation,
                        padding: const EdgeInsets.only(left: UiPadding.large),
                        child: const TextWidget(text: "Escrever comentário..."),
                      ),
                      onTap: () => _showModal(
                        context,
                        'index',
                        true,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
