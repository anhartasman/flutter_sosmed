import 'dart:async';

import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';
import 'package:fluttersosmed/architectures/domain/repositories/UserRepository.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

class AllUserUseCase extends UseCase<List<UserProfile>, UserSearch> {
  AllUserUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Stream<List<UserProfile>>> call(
    UserSearch userSearch,
  ) async {
    final StreamController<List<UserProfile>> controller = StreamController();

    repository.getAllUser(userSearch).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error AllUserUseCase ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}
