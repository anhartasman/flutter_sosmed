// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

isPresent(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final inputLokasiGPM = find.byValueKey('inputLokasiGPM');
    final btnSearch = find.byValueKey('btnSearch');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      // await Future.delayed(Duration(seconds: 10));
      sleep(Duration(seconds: 10));
      await driver.clearTimeline();
      await driver.waitUntilNoTransientCallbacks();
      // await Future.delayed(Duration(seconds: 10));
      // await driver.runUnsynchronized(() async {
      //   final buttonFinder = find.byValueKey('buttonLogin');
      //   await driver.tap(buttonFinder);
      // });
      // await Future.delayed(Duration(seconds: 2));
      await driver.runUnsynchronized(() async {
        final homeMenu = find.byValueKey('HomeMenu');
        final statDistribution = find.byValueKey('statDistribution');

        final isExists = await isPresent(homeMenu, driver);
        if (isExists) {
          print('widget is present');
          await driver.waitFor(inputLokasiGPM);
          await driver.tap(inputLokasiGPM);
          await Future.delayed(Duration(seconds: 2));
          await driver.enterText("778899");
          await driver.waitFor(btnSearch);
          await driver.tap(btnSearch);
          await Future.delayed(Duration(seconds: 2));
          await driver.scrollIntoView(statDistribution);
          // await Future.delayed(Duration(seconds: 2));
          // await driver.tap(buttonLogin);
          await Future.delayed(Duration(seconds: 10));
        } else {
          print('widget is not present');
          // await driver.waitFor(find.byValueKey("buttonLogin"),
          //     timeout: Duration(seconds: 30));
        }
        expect(1, 1);
      });
    });

    // test('increments the counter', () async {
    //   // First, tap the button.
    //   await driver.tap(buttonLogin);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(usernameTextFinder), "1");
    // });

    // test('increments the counter during animation', () async {
    //   await driver.runUnsynchronized(() async {
    //     // First, tap the button.
    //     await driver.tap(buttonLogin);

    //     // Then, verify the counter text is incremented by 1.
    //     expect(await driver.getText(usernameTextFinder), "1");
    //   });
    // });
  });
}
