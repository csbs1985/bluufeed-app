import 'package:intl/intl.dart';

class DataClass {
  String dataInteira(String data) {
    DateTime dateTime = DateTime.parse(data);
    DateFormat formatter = DateFormat("'dia' dd 'de' MMMM 'de' y", 'pt_BR');
    return formatter.format(dateTime);
  }

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

    if (difference.inDays < 2) {
      return "ontem";
    }

    if (difference.inDays < 7) {
      DateFormat formatter = DateFormat("EEE", 'pt_BR');
      return formatter.format(dateTime);
    }

    DateFormat formatter = DateFormat("dd 'de' MMM 'de' y", 'pt_BR');
    return formatter.format(dateTime);
  }
}
