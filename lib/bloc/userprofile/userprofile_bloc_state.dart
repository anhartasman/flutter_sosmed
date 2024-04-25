import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';

abstract class UserProfileBlocState extends Equatable {
  const UserProfileBlocState();
  @override
  List<Object> get props => [];
}

class UserProfileBlocStateOnIdle extends UserProfileBlocState {
  const UserProfileBlocStateOnIdle();
}

class UserProfileBlocStateOnStarted extends UserProfileBlocState {}

class UserProfileBlocStateOnSuccess extends UserProfileBlocState {
  final UserProfile userProfile;
  const UserProfileBlocStateOnSuccess(this.userProfile);
}

class UserProfileBlocStateOnError extends UserProfileBlocState {
  final String errorMessage;
  UserProfileBlocStateOnError(this.errorMessage);
}
