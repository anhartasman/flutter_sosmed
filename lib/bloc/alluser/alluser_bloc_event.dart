import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';

abstract class AllUserBlocEvent {}

class AllUserBlocRetrieve extends AllUserBlocEvent {
  final UserSearch userSearch;
  AllUserBlocRetrieve(this.userSearch);
}
