import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toFormattedString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
