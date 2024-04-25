import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';

abstract class FeedRepository {
  Future<List<UserFeed>> userFeed(FeedSearch feedSearch);
  Future<void> toggleLike(int feedId, bool like);
}
