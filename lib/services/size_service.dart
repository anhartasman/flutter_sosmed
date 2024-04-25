import 'package:get/get.dart';

class SizeService extends GetxService {
  Future<SizeService> init() async => this;
  double appWidth = 0.0;
  double appHeight = 0.0;
  void setAppSize(double appWidthx, appHeightx) {
    appWidth = appWidthx;
    appHeight = appHeightx;
  }
}
