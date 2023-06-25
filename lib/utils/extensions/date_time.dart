import 'package:intl/intl.dart';

extension Convert on DateTime? {
  get toHour => this == null ? "" : DateFormat.jm().format(this!);
}