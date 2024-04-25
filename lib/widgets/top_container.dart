import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/services/size_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double? height;
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  TopContainer({
    this.height,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final sizeService = Get.find<SizeService>();
    final double width = sizeService.appWidth;
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: color ?? Warna.warnaUtama,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
