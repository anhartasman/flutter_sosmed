import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/bloc/home_nav/bloc.dart';
import 'package:fluttersosmed/bloc/userfeed_search/bloc.dart';
import 'package:fluttersosmed/helpers/resizer/fetch_pixels.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/screens/home/home_feed_page.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import 'package:fluttersosmed/widgets/ShimmerHome.dart';
import 'package:fluttersosmed/widgets/navbar/HomeNavBar.dart';

class home_main_page extends StatelessWidget {
  final bool isPIC;
  const home_main_page({
    super.key,
    this.isPIC = false,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // FetchPixels();
    // final authService = Get.find<AuthService>();

    // var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider<UserFeedSearchBloc>(
      create: (BuildContext context) => di.sl<UserFeedSearchBloc>()
        ..add(UserFeedSearchBlocRetrieve(FeedSearch(page: 0))),
      child: home_feed_page(),
    );
  }
}
