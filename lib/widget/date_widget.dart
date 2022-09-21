import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:bluuffed_app/modal/comment_modal.dart';
import 'package:bluuffed_app/model/comment_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/widget/label_widget.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({required String type, required Map<String, dynamic> item})
      : _type = type,
        _item = item;

  final String _type;
  final Map<String, dynamic> _item;

  @override
  Widget build(BuildContext context) {
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

    String _getAuthor(_item) {
      String? userStatus;
      String? userName;
      bool? isEdit;
      bool? isSigned;

      isEdit = _item['isEdit'];
      isSigned = _item['isSigned'];
      userName = _item['userName'];

      var author = '';

      if (_type == CommentTypeEnum.COMMENT.value) {
        userStatus =
            _item is CommentModel ? _item.userStatus : _item['userStatus'];
      }

      userStatus == UserStatusEnum.DELETED.value
          ? author = 'usuário deletado'
          : author = isSigned! ? userName! : 'anônimo';

      var temp = ' · $author';
      return isEdit! ? '$temp · editado' : temp;
    }

    return Wrap(
      children: [
        if (_type == CommentTypeEnum.HISTORY.value && _item['isAuthorized'])
          SvgPicture.asset(UiIcon.authorized),
        if (_type == CommentTypeEnum.HISTORY.value && _item['isAuthorized'])
          const LabelWidget(label: ' · '),
        LabelWidget(label: _getDate(_item['date'])),
        LabelWidget(label: _getAuthor(_item)),
      ],
    );
  }
}
