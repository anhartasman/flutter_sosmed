import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/bloc/home_nav/bloc.dart';
import 'package:fluttersosmed/helpers/colors/color_data.dart';
import 'package:fluttersosmed/helpers/resizer/fetch_pixels.dart';
import 'package:fluttersosmed/routes/app_routes.dart';
import 'package:fluttersosmed/screens/models/home_model_bottom_menu.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    FetchPixels();
    final authService = Get.find<AuthService>();

    // var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelHeight(20)),
      decoration: BoxDecoration(
        color: Warna.warnaUtama,
        boxShadow: [
          BoxShadow(
              color: shadowColor, blurRadius: 20, offset: const Offset(0, -2)),
        ],
      ),
      child: BlocConsumer<HomeNavBloc, HomeNavBlocState>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(bottomMenuList.length, (index) {
                final modelItem = bottomMenuList[index];
                final selected = state.menuActive == index;
                return GestureDetector(
                  onTap: () => changeMenu(context, index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: FaIcon(
                            modelItem.theIcon,
                            color: Colors.white,
                          ),
                        ),
                        Text(modelItem.nama,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 2,
                            width: 20,
                            color: selected ? Colors.white : Warna.warnaUtama,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }), // child:
    );
  }

  void changeMenu(BuildContext context, int index) {
    BlocProvider.of<HomeNavBloc>(context).add(HomeNavBlocChange(index));
  }
}
