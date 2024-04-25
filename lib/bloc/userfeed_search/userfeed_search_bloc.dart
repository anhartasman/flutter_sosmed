import 'package:bloc/bloc.dart';
import 'package:fluttersosmed/architectures/domain/usecases/UserFeedSearchUseCase.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

import './bloc.dart';

class UserFeedSearchBloc
    extends Bloc<UserFeedSearchBlocEvent, UserFeedSearchBlocState> {
  final UserFeedSearchUseCase userFeedSearchUseCase;

  UserFeedSearchBloc({
    required this.userFeedSearchUseCase,
  }) : super(UserFeedSearchBlocStateOnIdle()) {
    on<UserFeedSearchBlocEvent>((event, emit) async {
      if (event is UserFeedSearchBlocRetrieve) {
        emit(UserFeedSearchBlocStateOnStarted());
        final failureOrTrivia = await userFeedSearchUseCase(event.feedSearch);

        try {
          var userFeedSearch = await failureOrTrivia.first;

          emit(UserFeedSearchBlocStateOnSuccess(
            userFeedSearch,
          ));
        } catch (e) {
          emit(UserFeedSearchBlocStateOnError(e.toString()));
        }
      }
    });
  }
}
