import 'package:flutter/services.dart';
import 'package:fluttersosmed/helpers/extensions/ext_int.dart';
import 'package:fluttersosmed/helpers/extensions/ext_string.dart';

class InputSuffixRibuanFormatter extends TextInputFormatter {
  final String suffixText;
  final int? maxNumber;
  InputSuffixRibuanFormatter(this.suffixText, {this.maxNumber});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    final int textLength = text.length;
    int selectionIndex = newValue.selection.end;
    var theText = "";
    late final String convertedText;
    try {
      int angka = text.getAngka;
      if (maxNumber != null) {
        if (angka > maxNumber!) {
          angka = oldValue.text.getAngka;
        }
      }
      convertedText = angka.toRibuan();
      theText = convertedText + " $suffixText";
    } catch (e) {
      convertedText = "0";
      theText = convertedText + " $suffixText";
    }
    // int usedSubstringIndex = 0;
    // final StringBuffer buffer = StringBuffer();

    // if (textLength < 4) {
    //   buffer.write(text.substring(0, textLength));
    // }

    // // ### ### ####
    // if (textLength >= 4) {
    //   buffer.write(text.substring(0, usedSubstringIndex = 2));
    //   buffer.write(' ');
    //   buffer.write(text[3]);

    //   selectionIndex++;
    // }
    final textBaru = theText;
    return newValue.copyWith(
      text: textBaru,
      selection: TextSelection.collapsed(offset: convertedText.length),
    );
  }
}
