import 'package:bloc/bloc.dart';
import 'package:fluttersosmed/architectures/domain/usecases/ToggleLikeUseCase.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

import './bloc.dart';

class ToggleLikeBloc extends Bloc<ToggleLikeBlocEvent, ToggleLikeBlocState> {
  final ToggleLikeUseCase toggleLikeUseCase;

  ToggleLikeBloc({
    required this.toggleLikeUseCase,
  }) : super(ToggleLikeBlocState()) {
    on<ToggleLikeBlocEvent>((event, emit) async {
      if (event is ToggleLikeBlocSetStatus) {
        emit(state.copyWith(
          feedId: event.feedId,
          isLiked: event.isLiked,
        ));
      } else if (event is ToggleLikeBlocStart) {
        emit(state.copyWith(
          onLoading: true,
        ));
        final newStatus = !state.isLiked;
        final failureOrTrivia = await toggleLikeUseCase(ToggleLikeUseCaseParam(
          state.feedId,
          newStatus,
        ));

        try {
          await failureOrTrivia.first;

          emit(state.copyWith(
            onLoading: true,
            isLiked: newStatus,
          ));
        } catch (e) {}
        emit(state.copyWith(
          onLoading: false,
        ));
      }
    });
  }
}
