import 'package:fluttersosmed/architectures/domain/usecases/AllUserUseCase.dart';
import 'package:fluttersosmed/architectures/domain/usecases/ToggleFollowUseCase.dart';
import 'package:fluttersosmed/architectures/domain/usecases/ToggleLikeUseCase.dart';
import 'package:fluttersosmed/bloc/alluser/alluser_bloc.dart';
import 'package:fluttersosmed/bloc/toggle_follow/toggle_follow_bloc.dart';
import 'package:fluttersosmed/bloc/toggle_like/toggle_like_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttersosmed/architectures/data/repositories/DataFeedRepository.dart';
import 'package:fluttersosmed/architectures/data/repositories/DataUserRepository.dart';
import 'package:fluttersosmed/architectures/domain/repositories/FeedRepository.dart';
import 'package:fluttersosmed/architectures/domain/repositories/UserRepository.dart';
import 'package:fluttersosmed/architectures/domain/usecases/UserFeedSearchUseCase.dart';
import 'package:fluttersosmed/architectures/domain/usecases/UserProfileUseCase.dart';
import 'package:fluttersosmed/bloc/home_nav/bloc.dart';
import 'package:fluttersosmed/bloc/splash_check/splash_check_bloc.dart';
import 'package:fluttersosmed/bloc/userfeed_search/userfeed_search_bloc.dart';
import 'package:fluttersosmed/bloc/userprofile/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases

  sl.registerLazySingleton(() => UserFeedSearchUseCase(sl()));
  sl.registerLazySingleton(() => UserProfileUseCase(sl()));
  sl.registerLazySingleton(() => AllUserUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFollowUseCase(sl()));
  sl.registerLazySingleton(() => ToggleLikeUseCase(sl()));

  // Repository

  sl.registerLazySingleton<FeedRepository>(
    () => DataFeedRepository(),
  );
  sl.registerLazySingleton<UserRepository>(
    () => DataUserRepository(),
  );

  sl.registerFactory(
    () => HomeNavBloc(),
  );

  sl.registerFactory(
    () => SplashCheckBloc(),
  );

  sl.registerFactory(
    () => UserFeedSearchBloc(
      userFeedSearchUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => UserProfileBloc(
      userProfileUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => AllUserBloc(
      allUserUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ToggleFollowBloc(
      toggleFollowUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ToggleLikeBloc(
      toggleLikeUseCase: sl(),
    ),
  );
}
