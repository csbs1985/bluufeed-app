import 'package:algolia/algolia.dart';

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
}
