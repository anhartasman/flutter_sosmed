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
}
