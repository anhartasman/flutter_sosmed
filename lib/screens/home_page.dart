import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersosmed/screens/friend/friend_list_page.dart';
import 'package:fluttersosmed/screens/user/user_list_page.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/bloc/home_nav/bloc.dart';
import 'package:fluttersosmed/helpers/resizer/fetch_pixels.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/screens/feed_list/feed_list_page.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import 'package:fluttersosmed/widgets/navbar/HomeNavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    // var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider<HomeNavBloc>(
      create: (BuildContext context) => di.sl<HomeNavBloc>(),
      child: Scaffold(
        // backgroundColor: LightColors.kLightYellow,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: BlocConsumer<HomeNavBloc, HomeNavBlocState>(
            listener: (context, state) {
          if (state.openDrawer) {
            debugPrint("dengar buka drawer");
            scaffoldKey.currentState?.openDrawer();
          }
        }, builder: (BuildContext context, state) {
          if (state.menuActive == 0 || state.menuActive == -1) {
            return user_list_page();
          }
          if (state.menuActive == 1) {
            return WillPopScope(
              onWillPop: () {
                BlocProvider.of<HomeNavBloc>(context).add(HomeNavBlocChange(0));
                return Future.value(false);
              },
              child: feed_list_page(key: ValueKey("all")),
            );
          }
          if (state.menuActive == 2) {
            return WillPopScope(
              onWillPop: () {
                BlocProvider.of<HomeNavBloc>(context).add(HomeNavBlocChange(0));
                return Future.value(false);
              },
              child:
                  feed_list_page(key: ValueKey("favourite"), favourite: true),
            );
          }
          if (state.menuActive == 3) {
            return WillPopScope(
              onWillPop: () {
                BlocProvider.of<HomeNavBloc>(context).add(HomeNavBlocChange(0));
                return Future.value(false);
              },
              child: friend_list_page(),
            );
          }
          return WillPopScope(
            onWillPop: () {
              BlocProvider.of<HomeNavBloc>(context).add(HomeNavBlocChange(0));
              return Future.value(false);
            },
            child: Container(),
          );
        }),
        bottomNavigationBar: HomeNavBar(),
      ),
    );
  }
}
