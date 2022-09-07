import 'package:universe_history_app/model/comment_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/util/edit_date_util.dart';

String resumeUitl(item, {String? type}) {
  String? userStatus;
  String? date;
  String? userName;
  bool? isEdit;
  bool? isSigned;

  date = item['date'];
  isEdit = item['isEdit'];
  isSigned = item['isSigned'];
  userName = item['userName'];

  var time = editDateUtil(date!);
  var author = '';

  if (type == ContentType.COMMENT.name) {
    userStatus = item is CommentModel ? item.userStatus : item['userStatus'];
  }

  userStatus == UserStatusEnum.DELETED.name
      ? author = 'usuário deletado'
      : author = isSigned! ? userName! : 'anônimo';

  var temp = '$time · $author';
  return isEdit! ? '$temp · editado' : temp;
}

enum ContentType { COMMENT, HISTORY }
