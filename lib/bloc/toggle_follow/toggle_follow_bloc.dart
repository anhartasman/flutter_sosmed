import 'package:bloc/bloc.dart';
import 'package:fluttersosmed/architectures/domain/usecases/ToggleFollowUseCase.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

import './bloc.dart';

class ToggleFollowBloc
    extends Bloc<ToggleFollowBlocEvent, ToggleFollowBlocState> {
  final ToggleFollowUseCase toggleFollowUseCase;

  ToggleFollowBloc({
    required this.toggleFollowUseCase,
  }) : super(ToggleFollowBlocState()) {
    on<ToggleFollowBlocEvent>((event, emit) async {
      if (event is ToggleFollowBlocSetStatus) {
        emit(state.copyWith(
          userId: event.userId,
          isFollowed: event.isFollowed,
        ));
      } else if (event is ToggleFollowBlocStart) {
        emit(state.copyWith(
          onLoading: true,
        ));
        final newStatus = !state.isFollowed;
        final failureOrTrivia =
            await toggleFollowUseCase(ToggleFollowUseCaseParam(
          state.userId,
          newStatus,
        ));

        try {
          await failureOrTrivia.first;

          emit(state.copyWith(
            onLoading: true,
            isFollowed: newStatus,
          ));
        } catch (e) {}
        emit(state.copyWith(
          onLoading: false,
        ));
      }
    });
  }
}
