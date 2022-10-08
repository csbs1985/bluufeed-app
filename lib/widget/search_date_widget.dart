import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluuffed_app/widget/label_widget.dart';

class SearchDateWidget extends StatelessWidget {
  const SearchDateWidget({required Map<String, dynamic> item}) : _item = item;

  final Map<String, dynamic> _item;

  String _getDate(String _date) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(_date).millisecondsSinceEpoch);
    var diff = now.difference(date);
    var day = DateFormat('dd');
    var month = DateFormat('M');
    var year = DateFormat('yyyy');
    var hours = DateFormat('hh:mm');
    var time = '';
    var months = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez'
    ];

    if (diff.inSeconds < 60)
      time = 'agora';
    else if (diff.inMinutes < 60)
      time = 'à ' + diff.inMinutes.floor().toString() + ' min';
    else
      time = day.format(date) +
          ' de ' +
          months[int.parse(month.format(date)) - 1] +
          '. de ' +
          year.format(date) +
          ' às ' +
          hours.format(date);
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return LabelWidget(label: _getDate(_item['date']));
  }
}
