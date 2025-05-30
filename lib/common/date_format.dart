import 'package:flutter_chat_core/flutter_chat_core.dart';

String dateFormat(DateTime? datetime) {
  if (datetime == null) return "";
  DateTime now = DateTime.now();
  if (datetime.isAfter(now.add(Duration(days: 7)))) {
    return DateFormat.M().format(datetime.toLocal());
  } else if (datetime.isAfter(now.add(Duration(days: 1)))) {
    return DateFormat.E().format(datetime.toLocal());
  } else {
    return DateFormat.Hm().format(datetime.toLocal());
  }
}
