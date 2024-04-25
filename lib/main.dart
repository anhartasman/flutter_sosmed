import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttersosmed/screens/home_page.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import 'package:fluttersosmed/services/size_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/colors/light_colors.dart';
import 'package:fluttersosmed/routes/app_pages.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await di.init();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor:
    //       LightColors.kLightYellow, // navigation bar color
    //   statusBarColor: Warna.warnaUtama, // status bar color
    // ));
    await Get.putAsync(() => AuthService().init());
    await Get.putAsync(() => SizeService().init());

    return runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      getPages: appPages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
