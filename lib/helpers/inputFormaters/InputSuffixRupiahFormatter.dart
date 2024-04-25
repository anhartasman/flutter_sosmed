import 'package:flutter/services.dart';
import 'package:fluttersosmed/helpers/extensions/ext_int.dart';
import 'package:fluttersosmed/helpers/extensions/ext_string.dart';

class InputSuffixRupiahFormatter extends TextInputFormatter {
  final String suffixText;
  final int? maxNumber;
  InputSuffixRupiahFormatter(this.suffixText, {this.maxNumber});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text;
    final int textLength = text.length;
    int selectionIndex = newValue.selection.end;
    var theText = "";
    try {
      int angka = text.getAngka;
      if (maxNumber != null) {
        if (angka > maxNumber!) {
          angka = oldValue.text.getAngka;
        }
      }
      theText = angka.toRupiah();
    } catch (e) {
      theText = "Rp 0";
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
    final textBaru = theText + " " + suffixText;
    return newValue.copyWith(
      text: textBaru,
      selection: TextSelection.collapsed(offset: theText.length),
    );
  }
}
