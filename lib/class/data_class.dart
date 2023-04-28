import 'package:intl/intl.dart';

class DataClass {
  String dataFormatar(String data) {
    DateTime dateTime = DateTime.parse(data);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds.abs() <= 60) {
      return 'agora';
    } else if (difference.inMinutes.abs() <= 59) {
      int minutes = difference.inMinutes.abs();
      return '$minutes min';
    } else if (difference.inHours.abs() <= 23) {
      int hours = difference.inHours.abs();
      return '$hours horas';
    } else if (difference.inDays.abs() <= 6) {
      String weekday = DateFormat.EEEE('pt_BR').format(dateTime);
      return weekday;
    } else {
      String formattedDate =
          DateFormat('dd MMMM yyyy', 'pt_BR').format(dateTime);
      return formattedDate;
    }
  }
}
