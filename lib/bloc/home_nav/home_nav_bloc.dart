import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';

class HomeNavBloc extends Bloc<HomeNavBlocEvent, HomeNavBlocState> {
  HomeNavBloc() : super(HomeNavBlocState()) {
    on<HomeNavBlocEvent>((event, emit) async {
      if (event is HomeNavBlocChange) {
        emit(state.copyWith(menuActive: event.menuNumber));
      } else if (event is HomeNavOpenDrawer) {
        debugPrint("buka drawer");
        emit(state.copyWith(
          openDrawer: true,
        ));
        Future.delayed(Duration(milliseconds: 500))
            .then((value) => add(HomeNavCloseDrawer()));
      } else if (event is HomeNavCloseDrawer) {
        debugPrint("tutup drawer");
        emit(state.copyWith(
          openDrawer: false,
        ));
      }
    });
  }
}
