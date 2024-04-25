import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';

abstract class UserFeedSearchBlocState extends Equatable {
  const UserFeedSearchBlocState();
  @override
  List<Object> get props => [];
}

class UserFeedSearchBlocStateOnIdle extends UserFeedSearchBlocState {
  const UserFeedSearchBlocStateOnIdle();
}

class UserFeedSearchBlocStateOnStarted extends UserFeedSearchBlocState {}

class UserFeedSearchBlocStateOnSuccess extends UserFeedSearchBlocState {
  final List<UserFeed> feedList;
  const UserFeedSearchBlocStateOnSuccess(this.feedList);
}

class UserFeedSearchBlocStateOnError extends UserFeedSearchBlocState {
  final String errorMessage;
  UserFeedSearchBlocStateOnError(this.errorMessage);
}
