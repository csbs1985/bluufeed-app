import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';

class Headline2 extends StatelessWidget {
  const Headline2({required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: UiPadding.large),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
