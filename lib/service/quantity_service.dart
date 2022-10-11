import 'package:intl/intl.dart';

class QuantityService {
  String quantity(int _value) {
    if (_value > 0)
      return NumberFormat.compact(locale: 'pt-BR').format(_value).toString();
    return 'nada aqui';
  }
}
