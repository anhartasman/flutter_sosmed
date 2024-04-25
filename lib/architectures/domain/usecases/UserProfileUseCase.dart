import 'dart:async';

import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/repositories/UserRepository.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

class UserProfileUseCase extends UseCase<UserProfile, int> {
  UserProfileUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Stream<UserProfile>> call(
    int userId,
  ) async {
    final StreamController<UserProfile> controller = StreamController();

    repository.getUser(userId).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error UserProfileUseCase ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}
