import 'package:flutter/material.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';

enum StatusAgenda {
  terjadwal,
  berlangsung,
  selesai,
  dibatalkan,
}

extension StatusAgendaExtension on StatusAgenda {
  static const labelMap = {
    StatusAgenda.terjadwal: "Terjadwal",
    StatusAgenda.berlangsung: "Berlangsung",
    StatusAgenda.selesai: "Selesai",
    StatusAgenda.dibatalkan: "Dibatalkan",
  };
  String get label => labelMap[this] ?? "";
  static const idMap = {
    StatusAgenda.terjadwal: "Terjadwal",
    StatusAgenda.berlangsung: "Berlangsung",
    StatusAgenda.selesai: "Selesai",
    StatusAgenda.dibatalkan: "Dibatalkan",
  };
  String get id => idMap[this]!;
  static const colorMap = {
    StatusAgenda.terjadwal: Warna.biru,
    StatusAgenda.berlangsung: Warna.orange,
    StatusAgenda.selesai: Warna.hijau,
    StatusAgenda.dibatalkan: Warna.merah,
  };
  Color get color => colorMap[this]!;
}

extension StatusAgendaStrExtension on String? {
  StatusAgenda get enumStatusAgenda {
    try {
      return StatusAgenda.values.firstWhere((element) => element.id == this);
    } catch (e) {
      return StatusAgenda.terjadwal;
    }
  }
}
