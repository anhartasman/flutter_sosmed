abstract class SplashCheckBlocEvent {}

class SplashCheckBlocCheckVersion extends SplashCheckBlocEvent {}

class SplashCheckStart extends SplashCheckBlocEvent {}

class SplashCheckBlocSuccessPermission extends SplashCheckBlocEvent {}

class SplashCheckBlocSuccessAuth extends SplashCheckBlocEvent {
  final bool isLoggedIn;
  SplashCheckBlocSuccessAuth({required this.isLoggedIn});
}
