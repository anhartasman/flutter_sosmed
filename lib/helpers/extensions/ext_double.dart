import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension fileParsing on File {
  double get sizeMB {
    try {
      int sizeInBytes = this.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      return sizeInMb;
    } catch (e) {
      debugPrint("fileParsing error ${e}");
      return 0;
    }
  }
}
