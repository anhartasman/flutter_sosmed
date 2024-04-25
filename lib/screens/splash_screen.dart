import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/bloc/splash_check/bloc.dart';
import 'package:fluttersosmed/routes/app_routes.dart';
import 'package:fluttersosmed/screens/SplashCheckPermission.dart';
import 'package:fluttersosmed/services/size_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/colors/light_colors.dart';
import 'package:fluttersosmed/widgets/SplashContent.dart';
import 'package:fluttersosmed/injection_container.dart' as di;

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final double appWidth = MediaQuery.of(context).size.width;
    final double appHeight = MediaQuery.of(context).size.height;

    final sizeService = Get.find<SizeService>();
    sizeService.setAppSize(appWidth, appHeight);
    // var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider<SplashCheckBloc>(
      create: (BuildContext context) =>
          di.sl<SplashCheckBloc>()..add(SplashCheckStart()),
      child: Scaffold(
        // backgroundColor: LightColors.kLightYellow,
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashCheckBloc, SplashCheckBlocState>(
            listener: (context, state) {
          if (state is SplashCheckOnSuccess) {
            Future.delayed(const Duration(milliseconds: 500))
                .then((value) => Get.offNamed(Routes.homeMenuRoute));
          }
        }, builder: (BuildContext context, state) {
          return SplashContent();
        }),
      ),
    );
  }

  void quitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
