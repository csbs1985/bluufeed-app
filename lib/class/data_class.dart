import 'package:intl/intl.dart';

class DataClass {
  String dataFormatar(String data) {
    DateTime dateTime = DateTime.parse(data);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 59) {
      return "agora";
    }

    if (difference.inMinutes < 59) {
      return "à ${difference.inMinutes} minutos";
    }

    if (difference.inHours < 24) {
      return "à ${difference.inHours} horas";
    }

    if (difference.inDays < 7) {
      DateFormat formatter = DateFormat("EEEE 'às' HH'h'mm'm'", 'pt_BR');
      return formatter.format(dateTime);
    }

    DateFormat formatter =
        DateFormat("dd 'de' MMM 'de' y 'às' HH'h'mm'm'", 'pt_BR');
    return formatter.format(dateTime);
  }
}
