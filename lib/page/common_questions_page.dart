import 'package:bluuffed_app/model/common_questions_model.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_widget.dart';
import 'package:bluuffed_app/widget/separator_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class CommonQuestionsPage extends StatelessWidget {
  CommonQuestionsPage({Key? key}) : super(key: key);

  final List<CommonQuestionsModel> allQuestions =
      CommonQuestionsModel.allQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Perguntas frequentes'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in allQuestions)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      UiPadding.large,
                      UiPadding.large,
                      UiPadding.large,
                      0,
                    ),
                    child: TextWidget(text: item.question),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      UiPadding.large,
                      UiPadding.medium,
                      UiPadding.large,
                      UiPadding.large,
                    ),
                    child: TextWidget(text: item.answer),
                  ),
                  const SeparatorWidget(),
                ],
              )
          ],
        ),
      ),
    );
  }
}
