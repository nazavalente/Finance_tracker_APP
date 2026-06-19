import 'package:intl/intl.dart';

class DateFormatter {
  static String short(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }

  static String full(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }
}
