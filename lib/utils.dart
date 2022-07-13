import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat("HH:mm").format(date);

  static String getDay(DateTime date) {
    int day = date.weekday;
    if (day == 1) return "Lundi";
    if (day == 2) {
      return "Mardi";
    } else if (day == 3) {
      return "Mercredi";
    } else if (day == 4) {
      return "Jeudi";
    } else if (day == 5) {
      return "Vendredi";
    } else if (day == 6) {
      return "Samedi";
    } else {
      return "Dimanche";
    }
  }
}
