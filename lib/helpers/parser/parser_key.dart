import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttersosmed/helpers/extensions/ext_int.dart';

class ParserKey {
  static String fromMap(Map<String, dynamic>? map, List<String> keys) {
    Map<String, dynamic> currentObj = {};
    String theResult = "";
    bool objTerisi = false;
    try {
      keys.asMap().forEach((idx, key) {
        if (idx == keys.length - 1) {
          if (objTerisi) {
            theResult = getString(currentObj, key);
          } else {
            final hasilCek = getString(map, key);
            print("dapat hasil ${key}" + hasilCek);
            theResult = hasilCek;
          }
        } else {
          if (objTerisi) {
            currentObj = currentObj[key];
          } else {
            objTerisi = true;
            currentObj = map![key];
          }
        }
      });
    } catch (e) {
      return "";
    }

    return theResult;
  }

  static List<Map<String, dynamic>> getMapList(
      Map<String, dynamic> map,
      String key,
      Map<String, dynamic> Function(Map<String, dynamic>) mapToMap) {
    try {
      final jschdhMap = map[key] ?? [];
      List<Map<String, dynamic>> timeListMap = [];

      jschdhMap.asMap().forEach((idx, key) {
        try {
          timeListMap.add(mapToMap(key));
        } catch (e) {
          debugPrint("error when parsing JSON " + jsonEncode(key));
        }
      });

      return timeListMap;
    } catch (e) {
      return [];
    }
  }

  static int getInt(Map<String, dynamic>? map, String key) {
    return getString(map, key).getAngka;
  }

  static String getString(Map<String, dynamic>? map, String key) {
    if (map == null) {
      return "";
    }
    if (map[key] == null) {
      return "";
    }
    return map[key].toString();
  }

  static int getTime(Map<String, dynamic>? map, String key) {
    final theStr = getString(map, key);
    late DateTime theDate;
    try {
      theDate = DateTime.parse(theStr);
    } catch (e) {
      theDate = DateTime.now();
    }
    return theDate.millisecondsSinceEpoch;
  }
}
