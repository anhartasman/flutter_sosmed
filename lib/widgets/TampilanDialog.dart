import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttersosmed/helpers/extensions/ext_double.dart';
import 'package:fluttersosmed/services/size_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:fluttersosmed/widgets/ButtonMain.dart';
import 'package:fluttersosmed/widgets/ButtonPutih.dart';

class TampilanDialog {
  static Future<File?> DialogFilePicker({
    bool fromFile = false,
  }) async {
    late File selectedImage;

    final picker = ImagePicker();
    late final String fileSource;
    if (fromFile) {
      fileSource = "file";
    } else {
      final Permission permission = Permission.camera;
      final isGranted = await permission.isGranted;

      if (isGranted) {
        await Get.dialog(Dialog(
          insetPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: _DialogSourceImage(),
        )).then((value) {
          if (value != null) {
            fileSource = value;
          }
        });
      } else {
        return Get.dialog(Dialog(
          insetPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: _DialogPermissionCamera(),
        ));
      }
    }

    try {
      if (fileSource == "kamera") {
        final pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 600,
          maxHeight: 400,
        );
        if (pickedFile != null) {
          File _image = File(pickedFile.path);
          if (_image.sizeMB > 1) {
            showDialogAlert("Ukuran File Melebihi Batasan");
            return null;
          }
          selectedImage = _image;

          return (selectedImage);
        }
      } else if (fileSource == "file") {
        final pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 600,
          maxHeight: 400,
        );
        if (pickedFile != null) {
          File _image = File(pickedFile.path);
          if (_image.sizeMB > 1) {
            showDialogAlert("Ukuran File Melebihi Batasan");
            return null;
          }
          selectedImage = _image;

          // debugPrint("balikan source");
          // debugPrint(value);
          return (selectedImage);
        }
      }
    } catch (e) {}

    return null;
  }

  static Future<void> showDialogAlert(
    String message, {
    String? title,
    bool withDelay = false,
    int delaySeconds: 1,
  }) {
    return showDialogPesan(
      message,
      title: title,
      isAlert: true,
      withDelay: withDelay,
      delaySeconds: delaySeconds,
      textColor: Colors.black,
    );
  }

  static Future<void> showDialogSuccess(
    String message, {
    String title: "Berhasil",
    bool withDelay = false,
    int delaySeconds: 1,
  }) {
    return showDialogPesan(
      message,
      title: title,
      withDelay: withDelay,
      delaySeconds: delaySeconds,
      textColor: Warna.WARNA_BIRU,
    );
  }

  static Future<void> showDialogPesan(
    String message, {
    String? title,
    bool isAlert = false,
    bool withDelay = false,
    int delaySeconds: 1,
    Color textColor: Warna.BLACK21,
  }) async {
    if (withDelay) {
      await Future.delayed(Duration(seconds: delaySeconds));
    }
    await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isAlert
                ? Image.asset(
                    "assets/icon/msg_alert.png",
                    height: 100,
                  )
                : FaIcon(
                    FontAwesomeIcons.solidCheckCircle,
                    size: 70,
                    color: Warna.WARNA_BIRU,
                  ),
            title != null
                ? Column(children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => Warna.hijau,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    )),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  static Future<bool> showDialogKonfirm(
    String tulisan, {
    BuildContext? context,
    GlobalKey? key,
    String txtNo = "Tidak",
    String txtYes = "Ya",
    String title = "Konfirmasi",
  }) async {
    bool isiKonfirm = false;
    await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icon/warning.png',
              width: 50,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Warna.BLACK21,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              tulisan,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Warna.BLACK21),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        isiKonfirm = true;
                        Get.back();
                      },
                      child: ButtonMain(txtYes)),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: ButtonPutih(txtNo))),
              ],
            )
          ],
        ),
      ),
    ));
    return isiKonfirm;
  }

  static Future<DateTime?> DatePicker({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool yearFirst: false,
  }) {
    return showRoundedDatePicker(
      context: Get.context!,
      locale: Locale("id", "ID"),
      initialDatePickerMode:
          yearFirst ? DatePickerMode.year : DatePickerMode.day,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 1)),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 2),
      borderRadius: 16,
    ).then((newDateTime) {
      return newDateTime;
      // if (newDateTime != null) {
      //   return newDateTime;
      // }

      // return initialDate ?? DateTime.now();
    });
  }
}

class _DialogSourceImage extends StatefulWidget {
  const _DialogSourceImage({
    super.key,
  });

  @override
  State<_DialogSourceImage> createState() => __DialogSourceImageState();
}

class __DialogSourceImageState extends State<_DialogSourceImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeService = Get.find<SizeService>();
    final double appWidth = sizeService.appWidth;

    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(8.0),
        right: Radius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 8.0,
              color: Warna.hijau,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pilih sumber gambar",
              style: PoppinsSemiBold12.copyWith(
                color: Warna.filePicker,
              ),
            ),
            Text(
              "Max. 1MB",
              style: PoppinsSemiBold12.copyWith(
                color: Warna.merah,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back(result: "file");
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Warna.hijau,
                              border: Border.all(
                                width: 1.0,
                                color: Warna.hijau,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 13.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Galeri",
                          style: PoppinsSemiBold12.copyWith(
                            color: Warna.filePicker,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back(result: "kamera");
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Warna.hijau,
                              border: Border.all(
                                width: 1.0,
                                color: Warna.hijau,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.0, 3.0), //(x,y)
                                  blurRadius: 13.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Kamera",
                          style: PoppinsSemiBold12.copyWith(
                            color: Warna.filePicker,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogPermissionCamera extends StatefulWidget {
  const _DialogPermissionCamera({
    super.key,
  });

  @override
  State<_DialogPermissionCamera> createState() =>
      __DialogPermissionCameraState();
}

class __DialogPermissionCameraState extends State<_DialogPermissionCamera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeService = Get.find<SizeService>();
    final double appWidth = sizeService.appWidth;

    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(8.0),
        right: Radius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 8.0,
              color: Warna.hijau,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Izin Akses Kamera Diperlukan",
              style: PoppinsSemiBold12.copyWith(
                color: Warna.filePicker,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: appWidth * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "Kembali",
                          style: PoppinsMedium11.copyWith(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openAppSettings().then((value) => Get.back());
                    },
                    child: Container(
                      width: appWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Warna.hijau,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "Izinkan",
                          style: PoppinsMedium11.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
