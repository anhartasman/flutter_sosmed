import 'package:logging/logging.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/feed_local_data_source.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/architectures/domain/repositories/FeedRepository.dart';

/// `DataProductCategoryRepository` is the implementation of `ProductCategoryRepository` present
/// in the Domain layer. It communicates with the server, making API calls to register, login, logout, and
/// store a `User`.
class DataFeedRepository implements FeedRepository {
  late Logger _logger;

  DataFeedRepository() {
    _logger = Logger('DataFeedRepository');
  }

  @override
  Future<List<UserFeed>> userFeed(FeedSearch feedSearch) async {
    final feedList = await FeedLocalDataSource.userFeed(feedSearch);

    return feedList;
  }

  @override
  Future<void> toggleLike(int feedId, bool like) async {
    final feedList = await FeedLocalDataSource.toggleLike(feedId, like);

    return feedList;
  }
}
