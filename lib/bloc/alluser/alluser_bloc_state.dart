import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';

abstract class AllUserBlocState extends Equatable {
  const AllUserBlocState();
  @override
  List<Object> get props => [];
}

class AllUserBlocStateOnIdle extends AllUserBlocState {
  const AllUserBlocStateOnIdle();
}

class AllUserBlocStateOnStarted extends AllUserBlocState {}

class AllUserBlocStateOnSuccess extends AllUserBlocState {
  final List<UserProfile> userList;
  const AllUserBlocStateOnSuccess(this.userList);
}

class AllUserBlocStateOnError extends AllUserBlocState {
  final String errorMessage;
  AllUserBlocStateOnError(this.errorMessage);
}
