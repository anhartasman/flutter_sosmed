import 'dart:io';
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await Process.run(
    '/Users/anhartasman/Library/Android/sdk/platform-tools/adb',
    [
      "-s",
      "emulator-5554",
      'shell',
      'pm',
      'grant',
      'com.klinops.personal',
      'android.permission.ACCESS_FINE_LOCATION'
    ],
  );
  integrationDriver();
  // await Process.run(
  //   '/Users/anhartasman/Library/Android/sdk/platform-tools/adb',
  //   [
  //     "-s",
  //     "emulator-5554",
  //     'shell',
  //     'pm',
  //     'grant',
  //     'com.klinops.personal',
  //     'android.permission.ACCESS_COARSE_LOCATION'
  //   ],
  // );
}
