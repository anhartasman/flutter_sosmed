import 'package:flutter/material.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';

enum StatusSurat {
  pengajuan,
  diverifikasi,
  ditolak,
  disetujui,
  dilaporkan,
  diperiksa,
  dibayarkan,
}

extension StatusSuratExtension on StatusSurat {
  static const labelMap = {
    StatusSurat.pengajuan: "Pengajuan",
    StatusSurat.diverifikasi: "Diverifikasi",
    StatusSurat.ditolak: "Ditolak",
    StatusSurat.disetujui: "Disetujui",
    StatusSurat.dilaporkan: "Dilaporkan",
    StatusSurat.diperiksa: "Diperiksa",
    StatusSurat.dibayarkan: "Dibayarkan",
  };
  String get label => labelMap[this] ?? "";
  static const idMap = {
    StatusSurat.pengajuan: "Pengajuan",
    StatusSurat.diverifikasi: "Diverifikasi",
    StatusSurat.ditolak: "Ditolak",
    StatusSurat.disetujui: "Disetujui",
    StatusSurat.dilaporkan: "Dilaporkan",
    StatusSurat.diperiksa: "Diperiksa",
    StatusSurat.dibayarkan: "Dibayarkan",
  };
  String get id => idMap[this]!;
  static const colorMap = {
    StatusSurat.pengajuan: Warna.orange,
    StatusSurat.diverifikasi: Warna.orange,
    StatusSurat.ditolak: Warna.merah,
    StatusSurat.disetujui: Warna.hijau,
    StatusSurat.dilaporkan: Warna.merah,
    StatusSurat.diperiksa: Warna.orange,
    StatusSurat.dibayarkan: Warna.hijau,
  };
  Color get color => colorMap[this]!;
}

extension StatusSuratStrExtension on String? {
  StatusSurat get enumStatusSurat {
    try {
      return StatusSurat.values.firstWhere((element) => element.id == this);
    } catch (e) {
      return StatusSurat.disetujui;
    }
  }
}
