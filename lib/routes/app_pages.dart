import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/routes/app_routes.dart';
import 'package:fluttersosmed/screens/home_page.dart';
import 'package:fluttersosmed/screens/splash_screen.dart';

final appPages = [
  GetPage(
    name: Routes.homeRoute,
    page: () => splash_screen(),
  ),
  GetPage(
    name: Routes.homeMenuRoute,
    page: () {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor:
      //       LightColors.kLightYellow, // navigation bar color
      //   statusBarColor: Warna.warnaUtama, // status bar color
      // ));
      return HomePage();
    },
    middlewares: [
      // MemberGuard(), // Add the middleware here
    ],
  ),
];
