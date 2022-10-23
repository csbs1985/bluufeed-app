import 'package:algolia/algolia.dart';
import 'package:bluuffed_app/model/user_model.dart';

class UserService {
  List<dynamic> _listUser = [];

  List<dynamic> algoliaToList(List<AlgoliaObjectSnapshot>? _list) {
    _listUser = [];

    for (var item in _list!)
      _listUser.add({
        'name': item.data['name'],
        'id': item.data['objectID'],
      });

    return _listUser;
  }

  void setCurrentUser(Map<String, dynamic> user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(user));
  }
}
