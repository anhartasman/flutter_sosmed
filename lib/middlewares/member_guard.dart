import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/routes/app_routes.dart';
import 'package:fluttersosmed/services/auth_service.dart';

class MemberGuard extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isLoggedIn
        ? null
        : const RouteSettings(name: Routes.authLoginRoute);
  }
}
