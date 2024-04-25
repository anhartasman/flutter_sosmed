import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';
import 'package:logging/logging.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/user_local_data_source.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/repositories/UserRepository.dart';

/// `DataProductCategoryRepository` is the implementation of `ProductCategoryRepository` present
/// in the Domain layer. It communicates with the server, making API calls to register, login, logout, and
/// store a `User`.
class DataUserRepository implements UserRepository {
  late Logger _logger;

  DataUserRepository() {
    _logger = Logger('DataUserRepository');
  }

  @override
  Future<UserProfile> getUser(int id) async {
    final feedList = await UserLocalDataSource.getUser(id);

    return feedList;
  }

  @override
  Future<List<UserProfile>> getAllUser(UserSearch userSearch) async {
    final feedList = await UserLocalDataSource.getAllUser(userSearch);

    return feedList;
  }

  @override
  Future<void> toggleFollow(int userId, bool follow) async {
    final feedList = await UserLocalDataSource.toggleFollow(userId, follow);

    return feedList;
  }
}
