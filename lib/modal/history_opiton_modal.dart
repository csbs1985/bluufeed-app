import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/modal/create_page.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HistoryOptionModal extends StatefulWidget {
  const HistoryOptionModal({Key? key}) : super(key: key);

  @override
  State<HistoryOptionModal> createState() => _HistoryOptionModalState();
}

class _HistoryOptionModalState extends State<HistoryOptionModal> {
  final HistoryClass historyClass = HistoryClass();

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const CreateModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAuthor() {
      return currentUser.value.first.id == currentHistory.value.first.userId
          ? true
          : false;
    }

    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Material(
          color: isDark ? UiColor.mainDark : UiColor.main,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(UiPadding.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SubtitleResumeWidget(
                  title: 'Opções',
                  resume: 'Opções para esta história.',
                ),
                const SizedBox(height: UiPadding.large),
                if (isAuthor())
                  OptionButton(
                    label: 'editar história',
                    icon: UiIcon.edit,
                    callback: (value) => _openModal(context),
                  ),
                if (isAuthor()) const SizedBox(height: UiPadding.medium),
                if (isAuthor())
                  OptionButton(
                    callback: (value) => {},
                    label: 'excluir história',
                    icon: UiIcon.delete,
                  ),
                if (!isAuthor()) const SizedBox(height: UiPadding.medium),
                if (!isAuthor())
                  OptionButton(
                    label: 'ver perfil do escritor',
                    icon: UiIcon.perfilActived,
                    callback: (value) => {},
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
