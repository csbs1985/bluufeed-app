import 'package:bluuffed_app/model/common_questions_model.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatelessWidget {
  QuestionsPage({Key? key}) : super(key: key);

  final List<CommonQuestionsModel> allQuestions =
      CommonQuestionsModel.allQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBackWidget(option: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: UiPadding.large),
              child: Headline1(title: 'Perguntas frequentes'),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(UiPadding.large),
                      child: TextWidget(
                        text: '${allQuestions[index].question}'
                            '\n\n'
                            '${allQuestions[index].answer}',
                      ),
                    ),
                    const BorderWidget(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
