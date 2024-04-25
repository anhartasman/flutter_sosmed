import 'dart:ui';

Color backGroundColor = "#FFFFFF".toColor();
Color buttonbgColor = const Color(0xFF8DDB90);
Color homeBg = "#BDE3BF".toColor();
Color bgColor = "#E8FFE8".toColor();
Color buttonColor = const Color(0xFF17721A);
Color textColor = "#9B9B9B".toColor();
Color subtext = "#545454".toColor();
Color blueColor = "#2B66FF".toColor();
Color shadowColor = "#E4EBE4".toColor();
Color borderColor = "#CFCFCF".toColor();
Color progressColor = "#C2ECC4".toColor();
Color slotbg = "#DFFAE0".toColor();
Color homebgColor = "#E6F3E7".toColor();
Color unprogress = "#F3F3F3".toColor();
Color textFieldShadow = "#EAECEA".toColor();
Color containerShadow = "#3882A483".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
