import 'package:bloc/bloc.dart';
import 'package:fluttersosmed/architectures/domain/usecases/AllUserUseCase.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

import './bloc.dart';

class AllUserBloc extends Bloc<AllUserBlocEvent, AllUserBlocState> {
  final AllUserUseCase allUserUseCase;

  AllUserBloc({
    required this.allUserUseCase,
  }) : super(AllUserBlocStateOnIdle()) {
    on<AllUserBlocEvent>((event, emit) async {
      if (event is AllUserBlocRetrieve) {
        emit(AllUserBlocStateOnStarted());
        final failureOrTrivia = await allUserUseCase(event.userSearch);

        try {
          var allUser = await failureOrTrivia.first;

          emit(AllUserBlocStateOnSuccess(
            allUser,
          ));
        } catch (e) {
          emit(AllUserBlocStateOnError(e.toString()));
        }
      }
    });
  }
}
