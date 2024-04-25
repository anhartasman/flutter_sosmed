import 'package:bloc/bloc.dart';
import 'package:fluttersosmed/architectures/domain/usecases/UserProfileUseCase.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

import './bloc.dart';

class UserProfileBloc extends Bloc<UserProfileBlocEvent, UserProfileBlocState> {
  final UserProfileUseCase userProfileUseCase;

  UserProfileBloc({
    required this.userProfileUseCase,
  }) : super(UserProfileBlocStateOnIdle()) {
    on<UserProfileBlocEvent>((event, emit) async {
      if (event is UserProfileBlocRetrieve) {
        emit(UserProfileBlocStateOnStarted());
        final failureOrTrivia = await userProfileUseCase(event.userId);

        try {
          var userProfile = await failureOrTrivia.first;

          emit(UserProfileBlocStateOnSuccess(
            userProfile,
          ));
        } catch (e) {
          emit(UserProfileBlocStateOnError(e.toString()));
        }
      }
    });
  }
}
