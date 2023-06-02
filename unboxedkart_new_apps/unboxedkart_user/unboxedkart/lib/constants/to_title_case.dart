import 'package:unboxedkart/constants/constants.dart';
import 'package:intl/intl.dart';

var formatter = NumberFormat('#,##,000');

extension StringExtension on String {
  String toTitleCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeExtension on DateTime {
  String toReadableDate() {
    return "$day ${months[month - 1]} $year (${hour > 12 ? hour - 12 : hour} : $minute ${hour > 12 ? "PM" : "AM"})";
  }
}

extension ToCurrency on int {
  String toCurrency() {
    return formatter.format(int);
  }
}
