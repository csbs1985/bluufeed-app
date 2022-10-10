import 'package:flutter/material.dart';

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({
    required String resume,
  }) : _resume = resume;

  final String _resume;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      child: Text(
        _resume,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
