import 'package:flutter/material.dart';

class TagText extends StatelessWidget {
  const TagText({
    super.key,
    required String tag,
  }) : _tag = tag;

  final String _tag;

  @override
  Widget build(BuildContext context) {
    return Text(
      '#$_tag',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
