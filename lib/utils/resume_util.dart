import 'package:universe_history_app/model/comment_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

String resumeUitl(_item, {String? type}) {
  String? _userStatus;
  String? _date;
  String? _userName;
  bool? _isEdit;
  bool? _isSigned;

  _date = _item['date'];
  _isEdit = _item['isEdit'];
  _isSigned = _item['isSigned'];
  _userName = _item['userName'];

  var _time = editDateUtil(_date!);
  var author = '';

  if (type == ContentType.COMMENT.name) {
    _userStatus =
        _item is CommentModel ? _item.userStatus : _item['userStatus'];
  }

  _userStatus == UserStatus.DELETED.name
      ? author = 'usuário deletado'
      : author = _isSigned! ? _userName! : 'anônimo';

  var temp = _time + ' · ' + author;
  return _isEdit! ? temp + ' · editado' : temp;
}

enum ContentType { COMMENT, HISTORY }
