import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: UiPadding.small),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
