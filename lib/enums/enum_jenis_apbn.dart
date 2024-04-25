import 'package:flutter/material.dart';

enum JenisAPBN {
  pusat,
  dekonsentrasiProvinsi,
  dekonsentrasiKab,
  apbdProvinsi,
  apbdKab,
  csr,
  mandiri,
}

extension JenisAPBNExtension on JenisAPBN {
  static const labelMap = {
    JenisAPBN.pusat: "APBN Pusat",
    JenisAPBN.dekonsentrasiProvinsi: "APBN Dekonsentrasi Provinsi",
    JenisAPBN.dekonsentrasiKab: "APBN Dekonsentrasi Kab/kota",
    JenisAPBN.apbdProvinsi: "APBD Provinsi",
    JenisAPBN.apbdKab: "APBD Kab/Kota",
    JenisAPBN.csr: "CSR",
    JenisAPBN.mandiri: "Mandiri",
  };
  String get label => labelMap[this] ?? "";
  static const idMap = {
    JenisAPBN.pusat: "A",
    JenisAPBN.dekonsentrasiProvinsi: "B",
    JenisAPBN.dekonsentrasiKab: "C",
    JenisAPBN.apbdProvinsi: "D",
    JenisAPBN.apbdKab: "E",
    JenisAPBN.csr: "F",
    JenisAPBN.mandiri: "G",
  };
  String get id => idMap[this]!;
}

extension JenisAPBNStrExtension on String? {
  JenisAPBN get enumJenisAPBN {
    return JenisAPBN.values.firstWhere((element) => element.id == this);
  }
}
