// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ItemUpBlockComponent extends StatefulWidget {
  const ItemUpBlockComponent({required ActivitiesModel history})
      : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemUpBlockComponent> createState() => _ItemUpBlockComponentState();
}

class _ItemUpBlockComponentState extends State<ItemUpBlockComponent> {
  String _getText(String type) {
    return type == ActivitiesEnum.BLOCK_USER.toString().split('.').last
        ? 'Agora você pode ver e comentar tudo de <bold>${widget._history.content}</bold> e virse-versa.'
        : 'Usuário <bold>${widget._history.content}</bold> bloqueado. Vocês não poderam mais ver e comentar as histórias entre vocês.';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: IconCicleComponent(
                icon: uiSvg.block,
                color: uiColor.block_user,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32 - 20 - 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText(
                      style: uiTextStyle.text4,
                      tags: {
                        'bold': StyledTextTag(
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      },
                      text: _getText(widget._history.type),
                    ),
                    ResumeComponent(
                      resume: editDateUtil(DateTime.parse(widget._history.date)
                          .millisecondsSinceEpoch),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed("/blocked"),
    );
  }
}
