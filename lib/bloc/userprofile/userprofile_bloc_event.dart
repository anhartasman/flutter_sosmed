abstract class UserProfileBlocEvent {}

class UserProfileBlocRetrieve extends UserProfileBlocEvent {
  final int userId;
  UserProfileBlocRetrieve(this.userId);
}
