import 'package:intl/intl.dart';

abstract class Formats{
  static final price_formatD2 = NumberFormat.currency(
    locale: 'ru',
    symbol: '\$',
  );
  static final price_formatD8 = NumberFormat.currency(
    locale: 'ru',
    symbol: '\$',
    decimalDigits: 8,
  );
  static final percent_format = NumberFormat.decimalPercentPattern(
    locale: 'ru',
    decimalDigits: 2,
  );
  static final compact_format = NumberFormat.compact(locale: 'en');
  static final datetime_from_format = DateFormat('yyyy-MM-dd');
  static final datetime_to_format = DateFormat('yyyy-MM-dd – HH:mm:ss');
}