import 'dart:io';

import 'package:intl/intl.dart';

extension fileParsing on File {
  bool get isPDF {
    try {
      return this.path.toLowerCase().endsWith(".pdf");
    } catch (e) {
      return false;
    }
  }
}
