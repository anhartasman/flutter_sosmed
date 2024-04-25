import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';

class ButtonMain extends StatelessWidget {
  final String tulisan;
  const ButtonMain(this.tulisan, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Warna.hijau,
      ),
      child: Center(
        child: Text(tulisan,
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
