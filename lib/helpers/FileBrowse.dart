import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttersosmed/helpers/extensions/ext_bool.dart';
import 'package:fluttersosmed/helpers/extensions/ext_double.dart';
import 'package:fluttersosmed/widgets/TampilanDialog.dart';

class FileBrowse {
  static Future<File?> browsePDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        final selectedFile = File(result.files.single.path!);
        if (!selectedFile.isPDF) {
          throw ("Pilih File PDF");
        }
        if (selectedFile.sizeMB > 5) {
          throw ("Max 5 MB");
        }
        return selectedFile;
      }
    } catch (e) {
      TampilanDialog.showDialogAlert(e.toString());
    }
    return null;
  }
}
