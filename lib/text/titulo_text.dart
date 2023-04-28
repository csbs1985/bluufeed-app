import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:flutter/material.dart';

class TituloText extends StatelessWidget {
  const TituloText({super.key, required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: UiEspaco.small),
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
