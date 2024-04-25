import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttersosmed/helpers/extensions/ext_string.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/montserrat_style_text.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';

class CircleDate extends StatelessWidget {
  final DateTime theDate;
  const CircleDate({
    Key? key,
    required this.theDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: Warna.hijau,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(16),
      child: Center(
          child: Column(
        children: [
          Text(
            theDate.toTanggal("MMM"),
            style: PoppinsMedium11.copyWith(
              color: Colors.white,
              height: 1.5,
            ),
          ),
          Text(
            theDate.toTanggal("dd"),
            style: PoppinsBold13.copyWith(
              color: Colors.white,
              height: 1,
            ),
          ),
          Text(
            theDate.toTanggal("yyyy"),
            style: PoppinsMedium11.copyWith(
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      )),
    );
  }
}
