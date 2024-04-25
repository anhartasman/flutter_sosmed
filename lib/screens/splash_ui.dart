import 'package:flutter/material.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/colors/light_colors.dart';
import 'package:fluttersosmed/widgets/SplashContent.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Warna.icon,
      body: Center(
        child: SplashContent(),
      ),
    );
  }
}
