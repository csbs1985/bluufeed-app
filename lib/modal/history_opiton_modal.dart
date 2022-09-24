import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:flutter/material.dart';

class HistoryOptionModal extends StatefulWidget {
  const HistoryOptionModal({Key? key}) : super(key: key);

  @override
  State<HistoryOptionModal> createState() => _HistoryOptionModalState();
}

class _HistoryOptionModalState extends State<HistoryOptionModal> {
  @override
  Widget build(BuildContext context) {
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
                OptionButton(
                  callback: (value) => {},
                  label: 'editar história',
                  icon: UiIcon.edit,
                ),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  callback: (value) => {},
                  label: 'excluir história',
                  icon: UiIcon.delete,
                ),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  callback: (value) => {},
                  label: 'ver perfil do escritor',
                  icon: UiIcon.logoActived,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
