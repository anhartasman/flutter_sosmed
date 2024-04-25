import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersosmed/config/Versi.dart';
import 'package:fluttersosmed/routes/app_routes.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:fluttersosmed/widgets/PhotoUser.dart';
import 'package:fluttersosmed/widgets/TampilanDialog.dart';

class DrawerContent extends StatefulWidget {
  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final authService = Get.find<AuthService>();
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: warnaUtama,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    if (!authService.isLoggedIn) {
      return Container(
        color: Colors.white,
      );
    }
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final theUser = authService.theUser!;
    return Container(
      color: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: statusBarHeight + 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                PhotoUser(),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        theUser.phone,
                        style: PoppinsMedium12,
                      ),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(
                        theUser.profil.name,
                        style: PoppinsBold14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 3,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Akun",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.2,
                fontFamily: "Popins",
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.changePasswordFormRoute);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        'Ganti Password',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(
                  color: Colors.black12,
                  height: 2.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Panduan & Informasi",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.2,
                fontFamily: "Popins",
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        'Tutorial Penggunaan',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(
                  color: Colors.black12,
                  height: 2.0,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        'Pertanyaan Berulang (FAQs)',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(
                  color: Colors.black12,
                  height: 2.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      TampilanDialog.showDialogKonfirm("Ingin logout?")
                          .then((value) {
                        if (value) {
                          authService.logout().then(
                              (value) => Get.offAllNamed(Routes.homeRoute));
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                            color: Warna.hijau,
                            letterSpacing: 0.2,
                            fontFamily: "Popins",
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Warna.hijau, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Version ${VERSION_LABEL}",
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 0.2,
                  fontFamily: "Popins",
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
