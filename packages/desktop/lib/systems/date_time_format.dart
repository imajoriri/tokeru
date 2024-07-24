import 'package:intl/intl.dart';

class DateTimeFormat {
  String format(DateTime dateTime) {
    return DateFormat.yMMMMd('ja').add_jm().format(dateTime.toLocal());
  }
}
