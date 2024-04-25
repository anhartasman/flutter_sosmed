import 'dart:async';

import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/architectures/domain/repositories/FeedRepository.dart';
import 'package:fluttersosmed/architectures/usecase/usecase.dart';

class UserFeedSearchUseCase extends UseCase<List<UserFeed>, FeedSearch> {
  UserFeedSearchUseCase(this.repository);

  final FeedRepository repository;

  @override
  Future<Stream<List<UserFeed>>> call(
    FeedSearch feedSearch,
  ) async {
    final StreamController<List<UserFeed>> controller = StreamController();

    repository.userFeed(feedSearch).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error UserFeedSearchUseCase ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}
