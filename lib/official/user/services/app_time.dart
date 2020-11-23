import 'package:intl/intl.dart';

class AppTime {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  String dateWithTime =
      DateFormat.yMMMd().add_jm().format(DateTime.now()); //Nov 22, 2020 8:01 PM
  String month = DateFormat.MMMM().format(DateTime.now()); //November
  String day = DateFormat.EEEE().format(DateTime.now()); //Sunday
  String time = DateFormat.jm().format(DateTime.now());
}
