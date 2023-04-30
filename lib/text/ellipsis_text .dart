import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  const EllipsisText({
    super.key,
    required String texto,
  }) : _texto = texto;

  final String _texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: UiEspaco.large),
      child: Text(
        _texto,
        maxLines: 10,
        style: Theme.of(context).textTheme.displayMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
