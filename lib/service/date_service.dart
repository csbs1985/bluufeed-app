class DateService {
  int qtyDays(String _upDateName) {
    var _date = DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(_upDateName).millisecondsSinceEpoch);
    var _now = DateTime.now();
    var _diff = _now.difference(_date);
    return _diff.inDays;
  }
}

enum DateEnum {
  ACTIVITY('activity'),
  COMMENT('comment'),
  HISTORY('history'),
  PERFIL('perfil'),
  SEARCH_HISTORY('search_history');

  final String value;
  const DateEnum(this.value);
}
