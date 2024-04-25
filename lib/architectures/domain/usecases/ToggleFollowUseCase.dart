import 'dart:async';

import 'package:fluttersosmed/architectures/domain/repositories/UserRepository.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

class ToggleFollowUseCase extends UseCase<void, ToggleFollowUseCaseParam> {
  ToggleFollowUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Stream<void>> call(
    ToggleFollowUseCaseParam param,
  ) async {
    final StreamController<void> controller = StreamController();

    repository.toggleFollow(param.userId, param.follow).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error ToggleFollowUseCase ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}

class ToggleFollowUseCaseParam {
  final int userId;
  final bool follow;
  ToggleFollowUseCaseParam(this.userId, this.follow);
}
