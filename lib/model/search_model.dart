class SearchMenuModel {
  late String key;
  late String value;

  SearchMenuModel({
    required this.key,
    required this.value,
  });
}

enum SearchMenuEnum {
  HISTORY('history'),
  USER('user');

  final String value;
  const SearchMenuEnum(this.value);
}
