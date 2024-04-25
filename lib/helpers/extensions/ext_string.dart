import 'dart:io';

import 'package:intl/intl.dart';
import 'package:fluttersosmed/helpers/extensions/ext_date.dart';
import 'package:fluttersosmed/helpers/extensions/ext_int.dart';
import 'package:fluttersosmed/helpers/formatters/FormatterRupiah.dart';
import 'package:fluttersosmed/helpers/formatters/FormatterTanggal.dart';
import 'package:fluttersosmed/helpers/util_int.dart';
import 'package:path/path.dart' as p;

extension intParsing on int? {
  String toRupiah() {
    return FormatterRupiah.format(this);
  }

  String toRibuan() {
    return NumberFormat.currency(locale: 'id', name: "", decimalDigits: 0)
        .format(this ?? 0);
  }
}

extension doubleParsing on double {
  String toKM() {
    // double angka=10.57564212432323;
    double angka = this / 1000;
    print("origin angka:$angka");
    final angkaKomaSatu = double.parse(angka.toStringAsFixed(1));
    print("rounded:$angkaKomaSatu");
    final angkaKoma = angkaKomaSatu - angkaKomaSatu.truncate();
    print("fraction:$angkaKoma");
    String result =
        angkaKoma > 0 ? angka.toStringAsFixed(1) : angka.toStringAsFixed(0);
    // print("result:$result");

    return result + " Km";
  }
}

extension doubleNoNullParsing on double {
  String get toTon {
    // double angka=10.57564212432323;
    if (this < 1000) {
      return this.toDecimal + " Kg";
    }

    double angka = this / 1000;

    return angka.toDecimal + " Ton";
  }

  String get toDecimal {
    final desimal = UtilInt.getDecimalPlaces(this);

    String result =
        desimal > 0 ? this.toStringAsFixed(1) : this.toInt().toRibuan();
    // print("result:$result");

    return result;
  }
}

extension fileParsing on File {
  String get toFileName {
    final fileBaseName = p.basename(path);
    return fileBaseName;
  }
}

extension intNoNullParsing on int {
  String toTanggal(String formatTujuan) {
    final theDate = DateTime.fromMillisecondsSinceEpoch(this);
    final outputFormat = DateFormat(formatTujuan, "id");
    final outputDate = outputFormat.format(theDate);
    return outputDate;
  }

  String get topupStatus {
    if (this == 1) {
      return "Menunggu Transfer";
    }
    if (this == 2) {
      return "Diterima";
    }
    return "";
  }
}

extension tanggalStr on DateTime {
  String toTanggal(String formatTujuan) {
    final outputFormat = DateFormat(formatTujuan, "id");
    final outputDate = outputFormat.format(this);
    return outputDate;
  }
}

extension tglParsing on String {
  String konvertTanggal(String formatFrom, String formatTo) {
    return FormatterTanggal.konvert(
      formatFrom,
      formatTo,
      this,
    );
  }

  String get getPhoneNumber {
    final theAngka = this.getAngka.toString();
    String phoneNumber = "";
    if (theAngka.startsWith("62")) {
      return theAngka;
    }
    if (theAngka.startsWith("0")) {
      phoneNumber = "62" + theAngka.substring(1);
      return phoneNumber;
    }

    return "62" + theAngka;
  }
}

extension errorParsing on String {
  String get getErrorMsg {
    late final String errorMsg;
    if (contains("api_error")) {
      errorMsg = split("api_error")[1];
    } else {
      errorMsg = "Terdapat kesalahan. Silahkan coba lagi";
    }
    return errorMsg;
  }
}
