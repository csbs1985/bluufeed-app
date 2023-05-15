import 'package:bluufeed_app/class/data_class.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:flutter/material.dart';

class DataText extends StatelessWidget {
  final DataClass _dataClass = DataClass();

  DataText({
    super.key,
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        LegendaText(
          legenda: _dataClass.dataFormatar(_item['dataRegistro']),
        ),
      ],
    );
  }
}
