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

  // String _getAuthor(_item) {
  //   if (_type != DataEnum.ACTIVITY.value && _type != DataEnum.PERFIL.value) {
  //     String? userStatus;
  //     String? userName;
  //     bool? isEdit;
  //     bool? isSigned;

  //     isEdit = _item['isEdit'];
  //     isSigned = _item['isSigned'];
  //     userName = _item['userName'] ?? _item['userNickName'];
  //     //TODO: remover _item['userNickName'] quando zerar o DB

  //     var author = '';

  //     if (_type == DataEnum.COMMENT.value) {
  //       userStatus =
  //           _item is ComentarioModel ? _item.userStatus : _item['userStatus'];
  //     }

  //     if (_type != DataEnum.PERFIL.value) {
  //       userStatus == UserStatusEnum.DELETED.value
  //           ? author = 'usuário deletado'
  //           : author = isSigned! ? userName! : 'anônimo';
  //     }

  //     var temp = ' · $author';
  //     return isEdit! ? '$temp · editado' : temp;
  //   } else {
  //     return '';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        LegendaText(legenda: _dataClass.dataFormatar(_item['date'])),

        // if (_type == DataEnum.HISTORY.value && _item['isAuthorized'])
        //   SvgPicture.asset(UiIcon.authorized),
        // if (_type == DataEnum.HISTORY.value && _item['isAuthorized'])
        //   const LabelWidget(label: ' · '),
        // LabelWidget(label: _getDate(_item['date'])),
        // if (_type != DataEnum.ACTIVITY.value)
        //   LabelWidget(label: _getAuthor(_item)),
      ],
    );
  }
}
