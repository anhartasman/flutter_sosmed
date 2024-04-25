import 'dart:async';

import 'package:fluttersosmed/architectures/domain/repositories/FeedRepository.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

class ToggleLikeUseCase extends UseCase<void, ToggleLikeUseCaseParam> {
  ToggleLikeUseCase(this.repository);

  final FeedRepository repository;

  @override
  Future<Stream<void>> call(
    ToggleLikeUseCaseParam param,
  ) async {
    final StreamController<void> controller = StreamController();

    repository.toggleLike(param.feedId, param.like).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error ToggleLikeUseCase ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}

class ToggleLikeUseCaseParam {
  final int feedId;
  final bool like;
  ToggleLikeUseCaseParam(this.feedId, this.like);
}
