import 'dart:math';

import 'package:fluttersosmed/helpers/extensions/ext_string.dart';

class UtilMonth {
  static List<String> monthList() {
    List<String> monthList = [];
    for (int i = 1; i <= 12; i++) {
      final dateStr = "2024-${i.toString().padLeft(2, '0')}-01";
      final dateTime = DateTime.parse(dateStr);
      monthList.add(dateTime.toTanggal("MMMM"));
    }
    return monthList;
  }

  static List<String> yearList() {
    List<String> yearList = [];
    for (int i = 2020; i <= 2030; i++) {
      yearList.add(i.toString());
    }
    return yearList;
  }
}
