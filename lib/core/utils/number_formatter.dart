import 'package:intl/intl.dart';

class NumberFormatterCustom {
  static String formatPrice(double price) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(price);
  }

  static String formatPercentage(double percentage) {
    final formatter = NumberFormat('+0.00;-0.00', 'en_US');
    return '${formatter.format(percentage)}%';
  }
}
