import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserAccount.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';
import 'package:fluttersosmed/services/auth_service.dart';
import './bloc.dart';

class SplashCheckBloc extends Bloc<SplashCheckBlocEvent, SplashCheckBlocState> {
  SplashCheckBloc() : super(SplashCheckOnIdle()) {
    on<SplashCheckBlocEvent>((event, emit) async {
      if (event is SplashCheckStart) {
        emit(SplashCheckOnAuth());

        final authService = Get.find<AuthService>();
        authService.setIsLoggedIn(
          true,
          newUser: UserAccount(
            id: "1",
            email: "badudum@yahoo.com",
            profil: UserProfile(
              id: 0,
              name: "Badudum",
              profilePict: "https://picsum.photos/seed/badudum/300/300",
              coverPict: "https://picsum.photos/seed/badudum/500/300",
              followed: false,
              job: "",
            ),
            phone: "089765432",
          ),
        );
        add(SplashCheckBlocSuccessAuth(isLoggedIn: true));
      } else if (event is SplashCheckBlocSuccessAuth) {
        if (event.isLoggedIn) {
          emit(SplashCheckOnToken());

          emit(SplashCheckOnSuccess());
        } else {
          emit(SplashCheckOnSuccess());
        }
      }
    });
  }
}
