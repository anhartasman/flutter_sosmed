abstract class HomeNavBlocEvent {}

class HomeNavBlocChange extends HomeNavBlocEvent {
  final int menuNumber;
  HomeNavBlocChange(
    this.menuNumber,
  );
}

class HomeNavOpenDrawer extends HomeNavBlocEvent {}

class HomeNavCloseDrawer extends HomeNavBlocEvent {}
