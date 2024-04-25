import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';

abstract class UserFeedSearchBlocEvent {}

class UserFeedSearchBlocRetrieve extends UserFeedSearchBlocEvent {
  final FeedSearch feedSearch;
  UserFeedSearchBlocRetrieve(this.feedSearch);
}
