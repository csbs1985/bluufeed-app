import 'package:bluuffed_app/modal/comment_modal.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/date_widget.dart';
import 'package:bluuffed_app/widget/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class ActivityItemWidget extends StatefulWidget {
  const ActivityItemWidget({required Map<String, dynamic> snapshot})
      : _snapshot = snapshot;

  final Map<String, dynamic> _snapshot;

  @override
  State<ActivityItemWidget> createState() => _ActivityItemWidgetState();
}

class _ActivityItemWidgetState extends State<ActivityItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: UiPadding.large,
        vertical: UiPadding.medium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconActivityWidget(item: widget._snapshot),
          const SizedBox(width: UiPadding.large),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: StyledText(
                  style: Theme.of(context).textTheme.headline2,
                  text:
                      'Alguém, espero que seja você, entrou na sua conta History pelo aparelho <bold>${widget._snapshot['content']}</bold>.',
                  tags: {
                    'bold': StyledTextTag(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  },
                ),
              ),
              const SizedBox(height: UiPadding.small),
              DateWidget(
                type: CommentTypeEnum.ACTIVITY.value,
                item: widget._snapshot,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
