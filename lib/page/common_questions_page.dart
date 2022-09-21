import 'package:bluuffed_app/model/common_questions_model.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_widget.dart';
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            0,
            UiPadding.large,
            UiPadding.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in allQuestions)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: item.question),
                    const SizedBox(height: UiPadding.medium),
                    TextWidget(text: item.answer),
                    const SizedBox(height: UiPadding.xLarge),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
