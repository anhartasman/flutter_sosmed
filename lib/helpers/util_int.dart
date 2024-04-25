import 'dart:math';

class UtilInt {
  static int randomRange(int min, int max) {
    Random _random = Random();
    return min + _random.nextInt(max + 1);
  }

  static int getDecimalPlaces(double number) {
    List substr = number.toString().split('.');
    if (substr.length > 0) {
      return int.tryParse(substr[1]) ?? 0;
    }
    return 0;
  }
}
