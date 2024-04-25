import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';

abstract class UserRepository {
  Future<UserProfile> getUser(int id);
}
