import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';

abstract class UserRepository {
  Future<UserProfile> getUser(int id);
  Future<List<UserProfile>> getAllUser(UserSearch userSearch);
  Future<void> toggleFollow(int userId, bool follow);
}
