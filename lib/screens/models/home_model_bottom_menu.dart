import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeModelBottomMenu {
  final String nama;
  final IconData theIcon;
  const HomeModelBottomMenu(this.nama, this.theIcon);
}

const List<HomeModelBottomMenu> bottomMenuList = [
  HomeModelBottomMenu(
    "Home",
    FontAwesomeIcons.home,
  ),
  HomeModelBottomMenu(
    "Posts",
    FontAwesomeIcons.book,
  ),
  HomeModelBottomMenu(
    "Liked",
    FontAwesomeIcons.heart,
  ),
  HomeModelBottomMenu(
    "Profile",
    FontAwesomeIcons.user,
  ),
];
