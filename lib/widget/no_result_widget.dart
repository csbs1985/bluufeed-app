import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/separator_widget.dart';

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: UiSize.bottomNavigation,
          child: Text(
            _text,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        const SeparatorWidget(),
      ],
    );
  }
}
